# Certified Kubernetes Administrator (CKA) Study Notes

## 1. Kubernetes Cluster Setup Using Kubeadm
Tutorial in [Kubernetes Cluster Setup Using Kubeadm](https://github.com/Zoe-0925/Kubernetes-Study/tree/main/CKA-Certification-Study-Notes/Kubernetes%20Cluster%20Setup%20Using%20Kubeadm)
- Startup configurations
- Install kubelet, kubectl, and kubeadm
- Create a small cluster with 1 control plane and 2 worker nodes

## 2. Kubernetes Namespaces
Tutorial in [Kubernetes-namespaces.sh](https://github.com/Zoe-0925/Kubernetes-Study/blob/main/CKA-Certification-Study-Notes/Kubernetes-namespaces.sh)

## 3. Upgrade Kubernetes with kubeadm
Tutorial in [Upgrade-with-kubeadm](https://github.com/Zoe-0925/Kubernetes-Study/tree/main/CKA-Certification-Study-Notes/Upgrade-with-kubeadm)

## 4. Backing up and Restoring Kubernetes Data in etcd
Tutorial in [Backup-restore-etcd](https://github.com/Zoe-0925/Kubernetes-Study/tree/main/CKA-Certification-Study-Notes/Backup-restore-etcd)
- Back up etcd
- Restore etcd

## 5. Explore a Kubernetes cluster with kubectl
Tutorial in [Explore-with-kubectl]()
- Search a list of volumes with sorting
- Run commands inside a pod inside a namespace
- Create a Deployment Using a Spec File
- Delete a service
- Sample Command
``
kubectl exec {pod-name} -n {namespace-name} -- {shell script}
``
