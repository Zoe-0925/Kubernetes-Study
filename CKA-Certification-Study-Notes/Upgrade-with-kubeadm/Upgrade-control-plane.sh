#1. Upgrade kubeadm:
sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubeadm=1.22.2-00

#2. Make sure it upgraded correctly:
kubeadm version

#3. Drain the control plane node:
kubectl drain k8s-control --ignore-daemonsets

#4. Plan the upgrade:
sudo kubeadm upgrade plan v1.22.2

#5. Upgrade the control plane components:
sudo kubeadm upgrade apply v1.22.2

#6. Upgrade kubelet and kubectl on the control plane node:
sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubelet=1.22.2-00 kubectl=1.22.2-00

#7. Restart kubelet:
sudo systemctl daemon-reload
sudo systemctl restart kubelet

#8. Uncordon the control plane node:
kubectl uncordon k8s-control

#9. Verify the control plane is working:
kubectl get nodes

#If it shows a NotReady status, run the command again after a minute or so. It should become Ready.