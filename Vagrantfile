# Start Vagrant configuration using version 2 of the configuration format
Vagrant.configure("2") do |config|

  # Define the "nids" VM, which will act as the Network Intrusion Detection System
  config.vm.define "nids" do |nids|
    nids.vm.box = "ubuntu/jammy64"
    
    # By default, the first interface uses NAT for internet/SSH access.
    # Add a second interface: a host-only network for capturing IoT traffic
    nids.vm.network "private_network", type: "static", ip: "192.168.56.10", virtualbox__hostonly: "vboxnet0"
    
    # Configure VirtualBox provider-specific settings
    nids.vm.provider "virtualbox" do |vb|
      vb.memory = 4096
      vb.cpus = 2
      # Enable promiscuous mode on the second NIC to allow traffic sniffing
      vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    end
  end

  # Define the first IoT VM
  config.vm.define "iot" do |iot|
    iot.vm.box = "generic/alpine318"

    # First interface (NAT) is automatically added by Vagrant
    # Add second interface: host-only network for communicating with NIDS
    iot.vm.network "private_network", type: "static", ip: "192.168.56.11", virtualbox__hostonly: "vboxnet0"

    # Configure VirtualBox provider-specific settings
    iot.vm.provider "virtualbox" do |vb|
      vb.memory = 256
      vb.cpus = 1
    end

    # Provision script: simulate that the IoT device is ready to generate traffic
    iot.vm.provision "shell", inline: <<-SHELL
      echo "First IoT device is ready."
    SHELL
  end

  # Define a second IoT VM
  config.vm.define "iot2" do |iot2|
    iot2.vm.box = "generic/alpine318"
    
    # Add second interface: same host-only network as NIDS
    iot2.vm.network "private_network", type: "static", ip: "192.168.56.12", virtualbox__hostonly: "vboxnet0"

    # Configure VirtualBox provider-specific settings
    iot2.vm.provider "virtualbox" do |vb|
      vb.memory = 256
      vb.cpus = 1
    end

    # Provision script: simulate that the IoT device is ready to generate traffic
    iot2.vm.provision "shell", inline: <<-SHELL
      echo "Second IoT device is ready. Simulate more traffic here."
    SHELL
  end

  # Define a third IoT VM
  config.vm.define "iot3" do |iot3|
    iot3.vm.box = "generic/alpine318"

    # Add second interface: same host-only network as NIDS
    iot3.vm.network "private_network", type: "static", ip: "192.168.56.13", virtualbox__hostonly: "vboxnet0"

    # Configure VirtualBox provider-specific settings
    iot3.vm.provider "virtualbox" do |vb|
      vb.memory = 256
      vb.cpus = 1
    end

    # Provision script: simulate that the IoT device is ready to generate traffic
    iot3.vm.provision "shell", inline: <<-SHELL
      echo "Third IoT device is ready."
    SHELL
  end

end
