class appdeploy {

  # Install required tools
  package { ['curl', 'git']:
    ensure => installed,
  }

  # Install Node.js (v18)
  exec { 'install_node':
    command => 'curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs',
    path    => ['/bin', '/usr/bin'],
    unless  => 'node -v',
  }

  # Clone your React project from GitHub
  exec { 'clone_project':
    command => 'git clone https://github.com/harshitduttshukla/FintaUi.git /opt/fintaui',
    path    => ['/bin', '/usr/bin'],
    creates => '/opt/fintaui',
  }

  # Install dependencies using npm
  exec { 'install_dependencies':
    command => 'cd /opt/fintaui && npm install',
    path    => ['/bin', '/usr/bin'],
    require => Exec['clone_project'],
  }

  # Build the React project
  exec { 'build_react_app':
    command => 'cd /opt/fintaui && npm run build',
    path    => ['/bin', '/usr/bin'],
    require => Exec['install_dependencies'],
  }

  # Install serve globally (to serve the React build)
  exec { 'install_serve':
    command => 'npm install -g serve',
    path    => ['/bin', '/usr/bin'],
    unless  => 'which serve',
  }

  # Serve the built React app on port 3000
  exec { 'start_react_app':
    command => 'nohup serve -s /opt/fintaui/build -l 3000 &',
    path    => ['/bin', '/usr/bin'],
    require => Exec['build_react_app'],
  }
}
