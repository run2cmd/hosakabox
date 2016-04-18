# Class vagrantlocal::vim
#
# Configure and install VIM
#
class vagrantlocal::vim ($username){

  file {"/home/${username}/.vim":
    ensure  => directory,
    source  => "puppet:///modules/${module_name}/vim",
    owner   => $username,
    mode    => '0644',
    recurse => true
  }

  file {"/home/${username}/.vimrc":
    ensure => file,
    owner  => $username,
    mode   => '0644',
    source => "puppet:///modules/${module_name}/vimrc"
  }

}
