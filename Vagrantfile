BOX_IMAGE = "bento/ubuntu-18.04"

Vagrant.configure("2") do |config|

  config.vm.define "vault-server" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "vault"
    subconfig.vm.network "private_network", ip: "10.0.0.10"
    subconfig.vm.provider :virtualbox do |vb|
             vb.customize ['modifyvm', :id,'--memory', '512']
    end
    subconfig.vm.provision "shell" do |s|
      s.path = "install-vault.sh"
      s.args = ["10.0.0.10","server"]
    end
    subconfig.vm.provision "shell" do |s|
      s.path =  "install-consul.sh"
      s.args = ["10.0.0.10", '"10.0.0.10","10.0.0.11","10.0.0.12","10.0.0.13"', 'dc1', 0, "false"]
    end
  end

  config.vm.define "consul-1-server" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "consul-1"
    subconfig.vm.network "private_network", ip: "10.0.0.11"
    subconfig.vm.provider :virtualbox do |vb|
             vb.customize ['modifyvm', :id,'--memory', '512']
    end
    subconfig.vm.provision "shell" do |s|
      s.path =  "install-consul.sh"
      s.args = ["10.0.0.11", '"10.0.0.10","10.0.0.11","10.0.0.12","10.0.0.13"', 'dc1', 3, "true"]
    end
  end

  config.vm.define "consul-2-server" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "consul-2"
    subconfig.vm.network "private_network", ip: "10.0.0.12"
    subconfig.vm.provider :virtualbox do |vb|
             vb.customize ['modifyvm', :id,'--memory', '512']
    end
    subconfig.vm.provision "shell" do |s|
      s.path =  "install-consul.sh"
      s.args = ["10.0.0.12", '"10.0.0.10","10.0.0.11","10.0.0.12","10.0.0.13"', 'dc1', 0, "true"]
    end
  end

  config.vm.define "consul-3-server" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "consul-3"
    subconfig.vm.network "private_network", ip: "10.0.0.13"
    subconfig.vm.provider :virtualbox do |vb|
             vb.customize ['modifyvm', :id,'--memory', '512']
    end
    subconfig.vm.provision "shell" do |s|
      s.path =  "install-consul.sh"
      s.args = ["10.0.0.13", '"10.0.0.10","10.0.0.11","10.0.0.12","10.0.0.13"', 'dc1', 0, "true"]
    end
  end
end
