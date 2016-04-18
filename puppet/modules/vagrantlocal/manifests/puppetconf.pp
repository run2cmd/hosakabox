# Type: vagrantlocal::puppetconf
#
# Main and per user puppet configuration
#
define vagrantlocal::puppetconf ($conf, $module_path, $hiera_file, $file_owner){
  
  File_line {
    ensure  => present,
    path    => $conf,
    after   => 'ssldir.*',
    replace => true
  }

  exec {"Create ${conf}":
    path    => '/bin',
    command => "cp /etc/puppet/puppet.conf ${conf};chown ${file_owner} ${conf}",
    unless  => "test -f ${conf}"
  }

  file_line {"${conf} basemodulepath":
    line  => "basemodulepath = ${module_path}",
    match => 'basemodulepath =.*'
  }
  file_line {"${conf} hieraconfig":
    line  => "hiera_config = ${hiera_file}",
    match => 'hiera_config =.*'
  }
  file_line {"${conf} ordering":
    line  => 'ordering = manifest',
    match => 'ordering =.*'
  }
  file_line {"${conf} pluginsync":
    line  => 'pluginsync = true',
    match => 'pluginsync =.*'
  }
  file_line {"${conf} future parser":
    line  => 'parser = future',
    match => 'parser =.*'
  }

}
