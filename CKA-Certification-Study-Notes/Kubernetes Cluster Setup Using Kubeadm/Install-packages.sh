### Part 1: Config File for Containerd

#1. Create configuration file for containerd:
# Write overlay and br_netfilter into the file.
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

#2. Load modules:
sudo modprobe overlay
sudo modprobe br_netfilter

#3. Set system configurations for Kubernetes networking:
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

#net.bridge.bridge-nf-call-iptables = 1 
#  - enables netfilter on bridges to support iptables (firewall) rules.
#net.ipv4.ip_forward = 1 
#  - enables IPv4 forwarding which allows packets to be forwarded from one network interface to another.
#net.bridge.bridge-nf-call-ip6tables = 1 
#  - enables netfilter on bridges to support ip6tables (firewall) rules for IPv6.

#4. Apply new settings:
sudo sysctl --system



### Part 2: Install Containerd

#5. Install containerd:
sudo apt-get update && sudo apt-get install -y containerd.io

#6. Create default configuration file for containerd:
sudo mkdir -p /etc/containerd

#7. Generate default containerd configuration and save to the newly created default file:
sudo containerd config default | sudo tee /etc/containerd/config.toml

#8. Restart containerd to ensure new configuration file usage:
sudo systemctl restart containerd

#9. Verify that containerd is running:
sudo systemctl status containerd



### Part 3: Install Dependency Packages (kubeadm, kubectl, kubelet)

#10. Disable swap:
sudo swapoff -a

#11. Install dependency packages:
sudo apt-get update && sudo apt-get install -y apt-transport-https curl

#12. Download and add GPG key:
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

#13. Add Kubernetes to repository list:
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

#14. Update package listings:
sudo apt-get update

#15. Install Kubernetes packages (Note: If you get a dpkg lock message, just wait a minute or two before trying the command again):
sudo apt-get install -y kubelet=1.24.0-00 kubeadm=1.24.0-00 kubectl=1.24.0-00

#16. Turn off automatic updates:
sudo apt-mark hold kubelet kubeadm kubectl

