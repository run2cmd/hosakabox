# Class vagrantlocal::hosts
#
# Host entires for vagrant
#
class vagrantlocal::hosts ($hosts_list){

  $basehosts = {
    'localhost' => {
      ip                    => '127.0.0.1',
      host_aliases          => ['localhost.localdomain', 'localhost4', 'localhost4.localdomain4']
    },
  }
  
  create_resources(host, $basehosts, {ensure => 'present'})
  create_resources(host, $hosts_list, {ensure => 'present'})
  resources { 'host': purge => true }
}
