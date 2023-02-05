# Certified Kubernetes Administrator (CKA) Study Notes

## 1. Kubernetes Cluster Setup Using Kubeadm
### Part 1: Install the packages on 3 testing nodes.
- Create 3 nodes, 1 as the control plane and 2 as the worker nodes.
- Inside each node, enable iptables Bridged Traffic on all the Nodes
1. Create configuration file for containerd:
```sh
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
```
2. Load modules:
```sh
sudo modprobe overlay
sudo modprobe br_netfilter
```
3. Set system configurations for Kubernetes networking:
```sh
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
```
4. Apply new settings:
```sh
sudo sysctl --system
```
5. Install containerd:
```sh
sudo apt-get update && sudo apt-get install -y containerd.io
```
6. Create default configuration file for containerd:
```sh
sudo mkdir -p /etc/containerd
```
7. Generate default containerd configuration and save to the newly created default file:
```sh
sudo containerd config default | sudo tee /etc/containerd/config.toml
```
8. Restart containerd to ensure new configuration file usage:
```sh
sudo systemctl restart containerd
```
9. Verify that containerd is running:
```sh
sudo systemctl status containerd
```
10. Disable swap:
```sh
sudo swapoff -a
```
11. Install dependency packages:
```sh
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
```
12. Download and add GPG key:
```sh
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
```
13. Add Kubernetes to repository list:
```sh
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
```
14. Update package listings:
```sh
sudo apt-get update
```
15. Install Kubernetes packages (Note: If you get a dpkg lock message, just wait a minute or two before trying the command again):
```sh
sudo apt-get install -y kubelet=1.24.0-00 kubeadm=1.24.0-00 kubectl=1.24.0-00
```
16. Turn off automatic updates:
```sh
sudo apt-mark hold kubelet kubeadm kubectl
```