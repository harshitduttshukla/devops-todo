class appdeploy {
  package { ['curl', 'git']:
    ensure => installed,
  }

  exec { 'install_node':
    command => 'curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs',
    path    => ['/bin', '/usr/bin'],
    unless  => 'node -v',
  }

  exec { 'clone_project':
    command => 'git clone https://github.com/harshitduttshukla/FintaUi.git /opt/todo',
    path    => ['/bin', '/usr/bin'],
    creates => '/opt/todo',
  }

  exec { 'install_dependencies':
    command => 'cd /opt/todo && npm install && npm install -g serve',
    path    => ['/bin', '/usr/bin'],
    require => Exec['clone_project'],
  }

  exec { 'build_react':
    command => 'cd /opt/todo && npm run build',
    path    => ['/bin', '/usr/bin'],
    require => Exec['install_dependencies'],
  }

  exec { 'start_react':
    command => 'cd /opt/todo && serve -s build -l 8082 &',
    path    => ['/bin', '/usr/bin'],
    require => Exec['build_react'],
  }
}
