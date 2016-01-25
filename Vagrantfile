Vagrant.configure(2) do |config|
  config.vm.box = "BOXNAME"
  config.vm.box_check_update = false
# config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "10.10.10.100"
#  config.vm.network "public_network",
#	  	 use_dhcp_assigned_default_route: true,
#		 bridge: 'en0: Wi-Fi (AirPort)'
 # config.vm.synced_folder "sync/", "/vagrant_sync"
  config.vm.provider "virtualbox" do |vb|
    vb.name = "VMNAME"	
    vb.memory = "RAM"   
  end
  #config.vm.provision "shell", path: 'vm_prevision/provision.sh'
end
