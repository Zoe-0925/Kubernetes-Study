# Networking

## CNI plugins

## Kubernetes DNS
- Inside kube-system namespace
- Find the pod by domain name

## Networking Policies
- ingress = incoming traffic
  - from selector = ingress whitelist
- engress = outgoing traffic
  - to selector = engress whitelist
- Inside a cluster, each pod has a unique IP address
- Each cluster has a virtual network

## Verify the communication between 2 pods
Verify the two pods can communicate over the network.
Then Run curl on the IP address of the cyberdyne-frontend Pod
    kubectl get pods -o wide
    kubectl exec testclient -- curl <cyberdyne-frontend_POD_IP>

