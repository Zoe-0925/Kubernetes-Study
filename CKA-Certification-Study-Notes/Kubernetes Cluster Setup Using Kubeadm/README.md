# Certified Kubernetes Administrator (CKA) Study Notes

## 1. Kubernetes Cluster Setup Using Kubeadm
### Part 1: Install the packages on 3 testing nodes.
- Create 3 nodes, 1 as the control plane and 2 as the worker nodes.
- Inside each node, run the commands in the [Install-packages.sh](https://github.com/Zoe-0925/Kubernetes-Study/blob/main/CKA-Certification-Study-Notes/Kubernetes%20Cluster%20Setup%20Using%20Kubeadm/Install-packages.sh)

#### Notes - Why disable swap?
Swap space is used in Linux systems as an additional area of memory that can be used to temporarily store data when the system's physical memory (RAM) is full. In a normal operating system, when the physical memory is full, the operating system will write some of the data stored in memory to the swap space, freeing up memory for other applications.

In a Kubernetes cluster, however, it is recommended to disable swap space because of the following reasons:

Resource allocation: Kubernetes relies on accurate reporting of system resources to manage containers effectively. If swap is enabled, the system's memory usage might be reported as higher than it actually is, leading to over-allocation of resources.

Performance: Swap space is much slower than physical memory, and accessing it can lead to slow performance. This can affect the performance of containers running in the cluster, especially during high-memory usage scenarios.

Resource isolation: Kubernetes relies on cgroups to isolate resources for containers. Cgroups have limited support for swap and do not provide accurate control over the amount of swap used by containers.

Interference with kubelet: The kubelet, the component in Kubernetes that manages containers, expects that the system's memory utilization matches the actual memory utilization. If swap is enabled, it can interfere with the kubelet's ability to accurately monitor memory usage and make decisions about which containers to kill in low-memory situations.


### Part 2: Initialize the Cluster
On the control plane node, execute the commands in [Instantialize-clusters.sh](https://github.com/Zoe-0925/Kubernetes-Study/blob/main/CKA-Certification-Study-Notes/Kubernetes%20Cluster%20Setup%20Using%20Kubeadm/Instantialize-clusters.sh)

### Part 3: Install the Calico Network Add-On
On the control plane node, execute the commands in [Install-Calico.sh](https://github.com/Zoe-0925/Kubernetes-Study/blob/main/CKA-Certification-Study-Notes/Kubernetes%20Cluster%20Setup%20Using%20Kubeadm/Install-Calico.sh)

### Part 4: Join the Worker Nodes to the Cluster
On each of the worker node, execute the commands in [Join-workers.sh](https://github.com/Zoe-0925/Kubernetes-Study/blob/main/CKA-Certification-Study-Notes/Kubernetes%20Cluster%20Setup%20Using%20Kubeadm/Join-workers.sh)