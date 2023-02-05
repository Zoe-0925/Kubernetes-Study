#1. In the control plane node, create the token and copy the kubeadm join command:
kubeadm token create --print-join-command
#Note: This output will be used as the next command for the worker nodes.

#2. Copy the full output from the previous command used in the control plane node. 
#This command starts with kubeadm join.

#3. In both worker nodes, paste the full kubeadm join command to join the cluster. Use sudo to run it as root:
sudo kubeadm join... 

#4. In the control plane node, view cluster status:
kubectl get nodes