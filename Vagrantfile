# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "debian/wheezy64"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.vm.provision "bootstrap-puppet", type: "shell" do |shell|
    shell.path = "setup.sh"
  end

  config.vm.provision :puppet do |puppet|
    puppet.environment = "vagrant"
    puppet.environment_path = [:host, "puppet/environments"]
    puppet.hiera_config_path = "puppet/hiera.yaml"
    #puppet.options = "--verbose --debug --trace"
  end

  nodes = [
    {'id'=> 1, 'autostart'=> true},
    {'id'=> 2, 'autostart'=> true},
    {'id'=> 3, 'autostart'=> false},
    {'id'=> 4, 'autostart'=> false},
    {'id'=> 5, 'autostart'=> true},
  ]

  config.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true # disable default ssh port (see node configuration below)

  # configure each node "node-x" from nodes to have
  #   host     = node-x.local
  #   ip       = 192.168.56.1x
  #   ssh port = 220x
  # 
  # e.g. for node-1:
  #   host     = node-1.local
  #   ip       = 192.168.56.11
  #   ssh port = 2201
  nodes.each do |node_config|
    name = "node-#{node_config['id']}"
    ip = "192.168.56.1#{node_config['id']}"
    ssh_port = "220#{node_config['id']}"

    config.vm.define name, autostart: node_config['autostart'] do |node|
      node.vm.hostname = "#{name}.local"
      node.vm.network "private_network", ip: ip
      node.vm.network :forwarded_port, guest: 22, host: ssh_port, auto_correct: false
      node.ssh.guest_port = ssh_port
    end
  end
end
