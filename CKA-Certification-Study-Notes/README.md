# Certified Kubernetes Administrator (CKA) Study Notes

## 1. Kubernetes Cluster Setup Using Kubeadm
- Create 3 nodes, 1 as the control plane and 2 as the worker nodes.
- Inside each node, enable iptables Bridged Traffic on all the Nodes
```sh
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
```
