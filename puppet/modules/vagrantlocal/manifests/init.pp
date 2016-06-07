# Class: vagrantlocal
#
# Initial Vagrant setup 
#
class vagrantlocal {
  
  $packages = hiera('packages')
  $gems = hiera('gems')
  $path = hiera('env::path')
  $editor = hiera('env::editor')
  $pager = hiera('env::pager')
  $username = hiera('user::name')
  $password = hiera('user::pass')
  $hosts = hiera('hosts')
  $module_path = hiera('module_path')
  $hiera_file = hiera('hiera_file')

  $main_puppetfile = '/etc/puppet/puppet.conf'
  $user_puppetfile = "/home/${username}/.puppet/puppet.conf"

  package {$packages:
    ensure => latest
  }

  package {$gems:
    ensure   => latest,
    provider => 'gem'
  }

  user {$username:
    ensure           => present,
    comment          => 'Main dev user',
    expiry           => absent,
    groups           => 'wheel',
    password         => $password,
    password_max_age => '-1',
    shell            => '/bin/bash',
    home             => "/home/${username}",
    managehome       => true
  }

  class {'vagrantlocal::hosts':
    hosts_list => $hosts
  }

  class {'vagrantlocal::environment':
    path   => $path,
    editor => $editor,
    pager  => $pager
  }

  class {'vagrantlocal::vim':
    username => $username,
    require  => User[$username]
  }

  class {'vagrantlocal::screen':
    username => $username,
    require  => User[$username]
  }

  file {"/home/${username}/.puppet/":
    ensure => directory,
    owner  => $username,
    group  => $username,
    mode   => '0755'
  }

  file {$user_puppetfile:
    ensure => file,
    owner  => $username,
    group  => $username,
    mode   => '0755',
    source => "puppet:///modules/${module_name}/puppet.conf"
  }
  
  exec { 'Update mlocate':
    command => '/usr/bin/updatedb',
    require => Package['mlocate']
  }
  
}
