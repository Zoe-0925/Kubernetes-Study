#1. On the control plane node, install Calico Networking:
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml


#2. Check status of the control plane node:
kubectl get nodes