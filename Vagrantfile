Vagrant.configure("2") do |config|

  config.vm.box = "kaorimatz/centos-6.8-x86_64"

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false

  config.vm.network "forwarded_port", guest: 80, host: 3000, host_ip: "localhost", auto_correct: true
  config.vm.network "forwarded_port", guest: 8888, host: 4000, host_ip: "localhost", auto_correct: true
  config.vm.network "forwarded_port", guest: 5000, host: 5000, host_ip: "localhost", auto_correct: true
  config.vm.network "private_network", ip: "192.168.54.10"
  config.vm.hostname = "jobgrouper.build"

  config.vm.synced_folder "html", "/home/jobgrou2/public_html", :nfs => true

  config.vm.provision "shell", path: "manifests/puppet.sh"

  config.vm.provision "puppet" do |puppet|
	puppet.environment = 'jg'
	puppet.environment_path = 'puppet/environments'
  end

  config.vm.provision "shell", path: "manifests/php.sh"
  config.vm.provision "shell", path: "manifests/apache-config.sh"

  config.vm.provision "shell", run: "always", path: "manifests/startup.sh"

end
