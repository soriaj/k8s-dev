# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "jsoria/kubebase"
  config.vm.box_version = "2"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.define "kubebase-master" do |node|
    node.vm.hostname = "master"
    node.vm.provider "virtualbox" do |vb|
      vb.name = "kubebase-master"
      vb.memory = 2048
      vb.cpus = 2
    end
  end
end
