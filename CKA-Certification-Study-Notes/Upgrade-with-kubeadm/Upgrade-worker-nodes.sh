#Pre-requisite. Run the following on the control plane node to drain worker node 1:
kubectl drain k8s-worker1 --ignore-daemonsets --force
#You may get an error message that certain pods couldn't be deleted, which is fine.

#1. In a new terminal window, log in to worker node 1:
ssh cloud_user@<WORKER_1_PUBLIC_IP_ADDRESS>

#2. Upgrade kubeadm on worker node 1:
sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubeadm=1.22.2-00
kubeadm version

#3. Back on worker node 1, upgrade the kubelet configuration on the worker node:
sudo kubeadm upgrade node

#4. Upgrade kubelet and kubectl on worker node 1:
sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubelet=1.22.2-00 kubectl=1.22.2-00

#5. Restart kubelet:
sudo systemctl daemon-reload
sudo systemctl restart kubelet

#6. From the control plane node, uncordon worker node 1:
kubectl uncordon k8s-worker1
