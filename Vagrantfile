Vagrant.configure("2") do |config|
    config.vm.box = "bento/centos-7"
    config.vm.synced_folder "srv/salt", "/srv/salt/"
    config.vm.synced_folder "etc/salt/minion.d/", "/etc/salt/minion.d/"
    ## Use all the defaults:
    config.vm.provision :salt do |salt|
      salt.masterless = true
    end
  end
