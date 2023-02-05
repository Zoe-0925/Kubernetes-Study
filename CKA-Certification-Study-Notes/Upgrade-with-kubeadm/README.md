# Upgrade Kubernetes with kubeadm

## Notes on Upgrading a Control Plane
- Upgrade kubeadm
- Drain the control plane Node (Shut down)
- Use kubeadm to plan -> Execute the upgradation
- Upgrade the kubelet and kubectl
- Restart = Reload daemon + restart kubelet
- Uncordon the control plane node (Restart after the maintenance)

## Notes on Upgrading a Worker Node
- Drain the worker node from the control plane
- Upgrade kubeadm
- Upgrade the kubelet and kubectl
- Restart = Reload daemon + restart kubelet
- Uncordon the worker node from the control plane
