# class: vagrantlocal::screen 
#
# Sreenrc configuration
#
class vagrantlocal::screen ($username){

  file {"/home/${username}/.screenrc":
    ensure => file,
    owner  => $username,
    mode   => '0644',
    source => "puppet:///modules/${module_name}/screenrc"
  }

}
