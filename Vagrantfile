Vagrant.configure("2") do |config|
  config.vm.define "namenode" do |namenode|
    namenode.vm.box = "bento/ubuntu-18.04"
    namenode.vm.network "private_network", ip: "192.168.33.1"
    namenode.vm.hostname = "namenode"

    namenode.vm.synced_folder "sync", "/home/vagrant/sync"
    namenode.vm.synced_folder "ansible", "/home/vagrant/ansible"

    namenode.vm.provision "shell", inline: <<-SHELL
      apt install -y software-properties-common expect
      apt-add-repository ppa:ansible/ansible
      apt update && apt install -y ansible
      echo "\n192.168.33.1  namenode\n192.168.33.10  datanode01\n192.168.33.11  datanode02" >> /etc/hosts
      cp /home/vagrant/sync/config /home/vagrant/.ssh/config
      cp /home/vagrant/sync/deploy.sh /home/vagrant/deploy.sh
      cp /home/vagrant/sync/login.expect /home/vagrant/login.expect
      chown vagrant:vagrant /home/vagrant/login.expect
      chown vagrant:vagrant /home/vagrant/deploy.sh
      chown vagrant:vagrant /home/vagrant/.ssh/config
    SHELL
  end

  config.vm.define "datanode01" do |datanode01|
    datanode01.vm.box = "bento/ubuntu-18.04"
    datanode01.vm.network "private_network", ip: "192.168.33.10"
    datanode01.vm.hostname = "datanode01"

    datanode01.vm.provision "shell", inline: <<-SHELL
      echo "\n192.168.33.01  namenode\n192.168.33.10  datanode01\n192.168.33.11  datanode02" >> /etc/hosts
    SHELL
  end

  config.vm.define "datanode02" do |datanode02|
    datanode02.vm.box = "bento/ubuntu-18.04"
    datanode02.vm.network "private_network", ip: "192.168.33.11"
    datanode02.vm.hostname = "datanode02"

    datanode02.vm.provision "shell", inline: <<-SHELL
      echo "\n192.168.33.01  namenode\n192.168.33.10  datanode01\n192.168.33.11  datanode02" >> /etc/hosts
    SHELL
  end
end
