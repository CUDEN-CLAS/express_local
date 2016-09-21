# -*- mode: ruby -*-
# vi: set ft=ruby :

# Define the different servers that we want to create.
# Start with a webserver.
#
# TODO:
# Test webserver so that the inventory can move sites up and down the environment stack.
hosts = {

  "inventory.local" => "192.168.33.21",
  "express.local" => "192.168.33.20",
  #"logs.local" => "192.168.33.22",

}

# All Vagrant configuration is done below.
# The "2" in Vagrant.configure configures the configuration version.
# Please don't change it unless you know what you're doing.
Vagrant.configure(2) do |config|
  hosts.each do |name, ip|

    config.vm.define name do |machine|
      machine.vm.box = "bento/centos-7.2"
      machine.vm.box_url = "https://atlas.hashicorp.com/bento/boxes/centos-7.2"
      machine.vm.hostname = "%s" % name
      machine.vm.network :private_network, ip: ip

      machine.vm.provider "virtualbox" do |v|
        v.name = name

        if name.include? "express.local"
          v.customize ["modifyvm", :id, "--memory", 4096]
          v.customize ["modifyvm", :id, "--cpus", "2"]
        else
          v.customize ["modifyvm", :id, "--memory", 1024]
        end

        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      end

    end

    if name.include? "inventory.local"
      config.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/vm_inventory.yml"
        ansible.inventory_path = "ansible/hosts"
        ansible.vault_password_file = "~/.ansible_vault.txt"
        ansible.verbose = "vv"
      end
    end

    if name.include? "express.local"
      config.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/vm_express.yml"
        ansible.inventory_path = "ansible/hosts"
        ansible.vault_password_file = "~/.ansible_vault.txt"
      end
    end


    # if name.include? "logs.local"
    #   config.vm.provision "ansible" do |ansible|
    #     ansible.playbook = "ansible/vm_logs.yml"
    #     ansible.inventory_path = "ansible/hosts"
    #   end
    # end

    # Sync folders
    # We are using NFS because it is faster than rsync. The mount_options tell the VM to use:
    # NFS protocol version 3.
    # Absolute time for which file and directory entries are kept in the file-attribute cache after an update is 2 seconds.
    # Use the UDP protocol because it is faster than TCP
    config.vm.synced_folder "~/express_local/data/code", "/data/code", type: "nfs", mount_options: ["vers=3", "actimeo=2", "udp"]
  end
end
