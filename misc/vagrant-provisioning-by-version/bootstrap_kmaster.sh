#!/bin/bash

# Initialize Kubernetes --image-repository registry.aliyuncs.com/google_containers    >> /root/kubeinit.log 
echo "[TASK 1] Initialize Kubernetes Cluster 2>/dev/null"
sudo mkdir /etc/docker
sudo cat >>/etc/docker/daemon.json<<EOF
{
"exec-opts":["native.cgroupdriver=systemd"]
}
EOF

kubeadm config images list
kubeadm init  --apiserver-advertise-address=172.16.16.100 --pod-network-cidr=10.244.0.0/16 

# Copy Kube admin config
echo "[TASK 2] Copy kube admin config to Vagrant user .kube directory"
mkdir /home/vagrant/.kube
sudo cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown -R vagrant:vagrant /home/vagrant/.kube

# Deploy flannel network
echo "[TASK 3] Deploy flannel network"
su - vagrant -c "kubectl create -f /vagrant/kube-flannel.yml"

# Generate Cluster join command
echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
sudo kubeadm token create --print-join-command > /joincluster.sh
