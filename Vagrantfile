# -*- mode: ruby -*-
# vi: set ft=ruby :
required_plugins = %w(vagrant-vbguest)
required_plugins.each do |plugin|
  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vbguest.auto_update = true
  
  config.vm.define("cisprod01") do |d|
  d.vm.box = "centos/7"
  d.vm.hostname = "cisprod01"
  d.vm.network "private_network", ip: "192.168.1.112"
  d.vm.synced_folder "./resources", "/vagrant"
  d.vm.provision :shell, path: "scripts/passwordAuthentication.sh"
  d.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 1
    end
  end

  config.vm.define "commoncentos" do |d|
    d.vm.box = "centos/7"
    d.vm.hostname = "commoncentos"
    d.vm.network "private_network" , ip: "192.168.1.111"
    d.vm.synced_folder "./resources", "/vagrant"
    d.vm.provision :shell, path: "scripts/passwordAuthentication.sh"
    d.vm.provision :shell, path: "scripts/bootstrap_ansible.sh"
    d.vm.provision :shell, inline: "PYTHONUNBUFFERED=1 ansible-playbook -i /vagrant/ansible/hosts/server /vagrant/ansible/cisQuickStart.yml --extra-vars \"cisserver=cis-hosts\""
    d.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 1
    end
  end

end
