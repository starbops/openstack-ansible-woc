# -*- mode: ruby -*-
# vi: set ft=ruby :

storage_disk_path = "./tmp/storage_disk.vdi"
storage_disk_size = 20

Vagrant.configure("2") do |config|
  config.vm.hostname = "openstack"
  config.vm.box = "ubuntu/trusty64"

  config.vm.box_check_update = false

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = "2"
    vb.memory = "2048"
    unless File.exist?(storage_disk_path)
      vb.customize ["createhd", "--filename", file_to_disk, "--size", storage_disk_size * 1024]
    end
    vb.customize ["storageattach", :id, "--storagectl", "SATAController", "--port", 1, "--device", 0, "--type", "hdd", "--medium", storage_disk_path]
  end

  config.vm.provider "libvirt" do |domain|
    domain.cpus = "8"
    domain.memory = "8192"
    domain.storage :file, size: "20G"
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo -e "o\nn\np\n1\n\n\nw\nq" | fdisk /dev/sdb
  SHELL

  config.vm.provision "ansible" do |ansible|
    ansible.verbose = "v"
    ansible.playbook = "site.yml"
  end
end
