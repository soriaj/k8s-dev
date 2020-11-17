# -*- mode: ruby -*-
# vi: set ft=ruby :

MASTER_NODE_COUNT = 2
WORKER_NODE_COUNT = 1

VAGRANT_EXPERIMENTAL="dependency_provisioners"

Vagrant.configure("2") do |config|
  config.vm.box = "jsoria/kubebase"
  config.vm.box_version = "2"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Provision Control Plane Nodes
  (1..MASTER_NODE_COUNT).each do |i|
    config.vm.define "controller-#{i}" do |node|
      # Update name in VBox GUI
      node.vm.provider "virtualbox" do |vb|
        vb.name = "k8s-controller-#{i}"
        vb.memory = 2048
        vb.cpus = 2
      end
      # Define hostname in machine
      node.vm.hostname = "controller-#{i}"
      # Set private IP for communication
      node.vm.network :private_network, ip: "192.168.60.1#{i}"
      # Set ssh host port to prevent duplicate port
      node.vm.network "forwarded_port", guest: 22, host: "#{2210 + i}"
      # Set known hosts
      node.vm.provision "setup_hosts", type: "shell", :path => "./setup_hosts.sh" do |net|
        net.args = ["enp0s8"]
      end
      # Run ansible playbook
      if i == MASTER_NODE_COUNT
        node.vm.provision "ansible" do |ansible|
          ansible.limit = "all"
          ansible.playbook = "./playbooks/controller-playbook.yml"
        end
      end
    end
  end

  Provision Worker Nodes
  (1..WORKER_NODE_COUNT).each do |i|
    config.vm.define "worker-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "k8s-worker-#{i}"
        vb.memory = 512
        vb.cpus = 1
      end
      # Define hostname in machine# Set private IP for communication
      node.vm.network :private_network, ip: "192.168.60.2#{i}"
      # Set ssh host port to prevent duplicate port
      node.vm.network "forwarded_port", guest: 22, host: "#{2220 + i}"
      # Set known hosts
      node.vm.provision "setup_hosts", type: "shell", :path => "./setup_hosts.sh" do |net|
        net.args = ["enp0s8"]
      end
  end
end
