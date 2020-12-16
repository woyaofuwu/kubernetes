# kubernetes
Kubernetes playground

https://blog.csdn.net/jacksonary/article/details/88975460

kubeadm config images list
卸载node
k8s-master run: kubectl delete node k8s-node2
k8s-node2 run :
 kubeadm reset
 rm -rf /var/lib/cni/
 rm -rf /var/lib/etcd/*
# ifconfig cni0 down

# ip link delete cni0

# ifconfig flannel.1 down

# ip link delete flannel.1

# rm -rf /var/lib/cni/

# rm -rf /var/lib/etcd/*