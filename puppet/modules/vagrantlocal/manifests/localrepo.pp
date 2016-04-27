# Class vagrantlocal::localrepo
#
# Setup local yum repository
#
class vagrantlocal::localrepo {

  File {
    owner => 'root',
    group => 'root'
  }

  file { '/var/lib/yum/repos/_local':
    ensure  => directory,
    require => Package['createrepo']
  }

  file { '/etc/yum.repos.d/local.repo':
    ensure  => file,
    source  => "puppet:///modules/${module_name}/local.repo",
    require => Package['createrepo']
  }

  exec { 'Create local repo':
    path        => '/bin',
    command     => '/bin/createrepo -q /var/lib/yum/repos/_local',
    refreshonly => true,
    subscribe   => File['/etc/yum.repos.d/local.repo'],
    require     => Package['createrepo']
  }

  #Add SVN repo
  file {'/etc/yum.repos.d/wandisco-svn.repo':
    ensure => file,
    source => "puppet:///modules/${module_name}/wandisco-svn.repo"
  }

}
