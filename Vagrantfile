VAGRANTFILE_API_VERSION = '2'
SALT_BRANCH = 'stable'
SALT_VERSION = '2018.3.3'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  minions = [
    ['centos7', '512', 'bento/centos-7'],
    ['ubu18', '512', 'bento/ubuntu-18.04'],
  ]

  minions.each do |name, mem, os|
    config.vm.define name do |minion_config|
    minion_config.vm.synced_folder "srv/salt", "/srv/salt/"
    minion_config.vm.synced_folder "etc/salt/minion.d/", "/etc/salt/minion.d/"
    
    minion_config.vm.provider :virtualbox do |vb|
      vb.memory = mem
      vb.cpus = 1
    end
  
    minion_config.vm.box = os
    minion_config.vm.hostname = name

    minion_config.vm.provision :salt do |salt|
      salt.masterless = true
      salt.install_type = SALT_BRANCH
      salt.version = SALT_VERSION
    end
  end
end

end
