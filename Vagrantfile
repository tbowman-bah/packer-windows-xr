Vagrant.configure("2") do |config|
  config.vm.box = "packer_virtualbox_windows10EntEval.box"
	config.vm.boot_timeout = 1200

	# Configure Vagrant to use WinRM instead of SSH
  config.vm.communicator = "winrm"
 
  # Configure WinRM Connectivity
	config.winrm.basic_auth_only = true
  config.winrm.username = "vmr"
  config.winrm.password = "vmr"

	config.vm.provider "virtualbox" do |vb|
     # Display the VirtualBox GUI when booting the machine
     vb.gui = true
		 vb.name = "windows10R"
		 vb.customize ["modifyvm", :id, "--memory", 4096]
     vb.customize ["modifyvm", :id, "--cpus", 3]
     vb.customize ["modifyvm", :id, "--vram", 128]
     vb.customize ["modifyvm", :id, "--graphicscontroller","vboxsvga"]
     vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
     vb.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
     vb.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
  end
	
	config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./playbook.yml"
		ansible.inventory_path = "./group_vars/inventory.yml"
    ansible.extra_vars = {
      ansible_user: "vmr"
    }
		ansible.verbose = "-vvvv"
		ansible.limit= "windows"
  end
end

