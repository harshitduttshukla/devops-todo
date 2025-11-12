class appdeploy {
  package { ['curl', 'git']:
    ensure => installed,
  }

  # Install Node.js & npm
  exec { 'install-node':
    command => '/usr/bin/curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && apt-get install -y nodejs',
    path    => ['/bin', '/usr/bin'],
    unless  => '/usr/bin/node -v',
    require => Package['curl'],
  }

  # Clone the todo-list repository
  exec { 'clone-todo':
    command => '/usr/bin/git clone https://github.com/abdellatif-laghjaj/todo-list.git /opt/todo-list',
    creates => '/opt/todo-list/package.json',
    path    => ['/usr/bin', '/bin'],
    require => [Package['git'], Exec['install-node']],
  }

  # Install dependencies
  exec { 'npm-install':
    command => '/usr/bin/npm install',
    cwd     => '/opt/todo-list',
    path    => ['/usr/bin', '/bin'],
    require => Exec['clone-todo'],
  }

  # Start the Todo app
  exec { 'start-app':
    command => '/usr/bin/nohup npm start &',
    cwd     => '/opt/todo-list',
    path    => ['/usr/bin', '/bin'],
    require => Exec['npm-install'],
  }
}
