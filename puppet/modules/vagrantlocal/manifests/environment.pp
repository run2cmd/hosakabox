# Class: vagrantlocal::environment
#
# Local environment configuration
#
class vagrantlocal::environment ($path,$editor,$pager){

  file { '/etc/profile.d/dev_env.sh':
    ensure  => file,
    content => template("${module_name}/dev_env.sh.erb"),
    owner   => 'root',
    group   => 'root'
  }

}
