# -*- mode: ruby -*-
# vi: set ft=ruby :

storage_disk_path = "./tmp/storage_disk.vdi"

Vagrant.configure("2") do |config|
  config.vm.hostname = "openstack"
  config.vm.box = "ubuntu/trusty64"

  config.vm.box_check_update = false

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = "2"
    vb.memory = "8192"
    unless File.exist?("./tmp/storage_disk.vdi")
      vb.customize ["createhd", "--filename", "./tmp/storage_disk.vdi", "--size", 20 * 1024]
      vb.customize ["storageattach", :id, "--storagectl", "SATAController", "--port", 1, "--device", 0, "--type", "hdd", "--medium", "./tmp/storage_disk.vdi"]
    end
    unless File.exist?("./tmp/storage2_disk.vdi")
      vb.customize ["createhd", "--filename", "./tmp/storage2_disk.vdi", "--size", 10 * 1024]
      vb.customize ["storageattach", :id, "--storagectl", "SATAController", "--port", 2, "--device", 0, "--type", "hdd", "--medium", "./tmp/storage2_disk.vdi"]
    end
  end

  config.vm.provider "libvirt" do |domain|
    domain.random_hostname = true
    domain.cpus = "8"
    domain.memory = "8192"
    domain.storage :file, size: "20G"
    domain.storage :file, size: "10G"
  end

  config.vm.synced_folder './', '/vagrant', type: 'rsync'

  config.vm.provision "ansible" do |ansible|
    ansible.verbose = "v"
    ansible.playbook = "site.yml"
  end
end
