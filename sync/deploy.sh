#!/bin/bash

if [[ ! -d /home/vagrant/.ssh ]]
then
  mkdir /home/vagrant/.ssh
fi

if [[ ! -f .ssh/id_rsa ]]
then
  echo -e "No key found...\nCreating new key..."
  ssh-keygen -b 2048 -t rsa -f .ssh/id_rsa -q -N ""
else
  echo -e "Key present...\nSkipping action..."
fi

if [[ ! -f /home/vagrant/login.done ]]
then
  for f in namenode datanode01 datanode02
  do
    ./login.expect $f
  done
  echo "Logged to all hosts..."
  touch /home/vagrant/login.done
else
  echo "Logged to all hosts already..."
fi

sudo echo "deb [trusted=yes] http://public-repo-1.hortonworks.com/ambari/ubuntu16/2.x/updates/2.6.2.0 Ambari main" | sudo tee /etc/apt/sources.list.d/ambari.list

sudo chown -R vagrant:vagrant /home/vagrant

cd ansible
ansible-playbook names.yml
