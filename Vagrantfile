# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

# Check for missing plugins
required_plugins = %w(vagrant-triggers)
plugin_installed = false
required_plugins.each do |plugin|
  unless Vagrant.has_plugin?(plugin)
    system "vagrant plugin install #{plugin}"
    plugin_installed = true
  end
end
# If new plugins installed, restart Vagrant process
if plugin_installed === true
  exec "vagrant #{ARGV.join' '}"
end

settings = YAML.load_file 'settings.yaml'

# Configurable variables
image = settings['image']
ip_address = settings['ip_address']
hostname = settings['hostname']
vbname = settings['vbname']
vbmem = settings['vbmem']
vbcpu = settings['vbcpu']
user = settings['user']

# Main vagrant configuration
Vagrant.configure(2) do |config|

  config.vm.box = image

  config.vm.network 'private_network', ip: ip_address
  config.vm.hostname = hostname
  
  # Virtualbox name and assigned resources
  config.vm.provider 'virtualbox' do |vb|
    vb.name = vbname
    vb.memory = vbmem
    vb.cpus = vbcpu
  end

  config.vm.synced_folder 'C:\code', '/code', 
    owner: user,
    mount_options: ["dmode=775,fmode=664"]

  config.vm.synced_folder 'C:\pd', '/pd', 
    owner: user,
    mount_options: ["dmode=775,fmode=664"]

  # Puppet configuration
  config.vm.provision 'puppet' do |puppet|
    puppet.manifests_path = 'puppet'
    puppet.manifest_file  = 'site.pp'
    puppet.module_path = [ 'puppet/modules' ]
    puppet.hiera_config_path = 'puppet/hiera.yaml'
    puppet.working_directory = '/vagrant'
    #puppet.options = '--debug'
  end

end
