# -*- mode: ruby -*-
# vi: set ft=ruby :

# Define the different servers that we want to create.
# Start with a webserver.
#
# TODO:
# Test webserver so that the inventory can move sites up and down the environment stack.
hosts = {
  "express.local" => "192.168.33.20",
  #"inventory.local" => "192.168.33.21",
  #"logs.local" => "192.168.33.22",
}

# All Vagrant configuration is done below.
# The "2" in Vagrant.configure configures the configuration version.
# Please don't change it unless you know what you're doing.
Vagrant.configure(2) do |config|
  hosts.each do |name, ip|

    config.vm.define name do |machine|
      machine.vm.box = "bento/centos-6.7"
      machine.vm.box_url = "https://atlas.hashicorp.com/bento/boxes/centos-6.7"
      machine.vm.hostname = "%s" % name
      machine.vm.network :private_network, ip: ip

      machine.vm.provider "virtualbox" do |v|
        v.name = name

        if name.include? "express.local"
          v.customize ["modifyvm", :id, "--memory", 2048]
          v.customize ["modifyvm", :id, "--cpus", "2"]
        else
          v.customize ["modifyvm", :id, "--memory", 1024]
        end

        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      end

    end

    if name.include? "express.local"
      config.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/playbooks/vms/vm_express.yml"
        ansible.inventory_path = "ansible/hosts"
        ansible.ask_vault_pass = true
        ansible.extra_vars = {
          ansible_ssh_user: 'vagrant',
          ansible_connection: 'ssh'}
      end
    end

    if name.include? "inventory.local"
      config.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/playbooks/vms/vm_inventory.yml"
        ansible.inventory_path = "ansible/hosts"
        ansible.extra_vars = {
          ansible_ssh_user: 'vagrant',
          ansible_connection: 'ssh'}
      end
    end

    #sync folders
    config.vm.synced_folder "~/express_local/data", "/data", type: "nfs"
    config.vm.synced_folder "~/express_local/data/files", "/wwwng/sitefiles", type: "nfs"
  end
end
