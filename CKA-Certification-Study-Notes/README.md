# Certified Kubernetes Administrator (CKA) Study Notes

## Kubernetes Architecture
https://devopscube.com/kubernetes-architecture-explained/

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
Tutorial in [Explore-with-kubectl](https://github.com/Zoe-0925/Kubernetes-Study/tree/main/CKA-Certification-Study-Notes/Explore-with-kubectl)
- Search a list of volumes with sorting
- Run commands inside a pod inside a namespace
- Create a Deployment Using a Spec File
- Delete a service
- Sample Command
``
kubectl exec {pod-name} -n {namespace-name} -- {shell script}
``

## 6. Controlling Access in Kubernetes with RBAC
Tutorial in [Role-based-access-control](https://github.com/Zoe-0925/Kubernetes-Study/tree/main/CKA-Certification-Study-Notes/Role-based-access-control)
- Create a Role
- Bind the role to a user

## 7. Networking
Tutorial in [Networking](https://github.com/Zoe-0925/Kubernetes-Study/tree/main/CKA-Certification-Study-Notes/Networking)
- Kubernetes DNS
- Networking Policies
- Communication between 2 pods

## 8. Services
Tutorial in [Services](https://github.com/Zoe-0925/Kubernetes-Study/tree/main/CKA-Certification-Study-Notes/Services)
- Service Types
- Discover Services with DNS
- Managing Acess from Outside with Kubernetes Ingress

## 9. Storage
Tutorial in [Storage](https://github.com/Zoe-0925/Kubernetes-Study/tree/main/CKA-Certification-Study-Notes/Storage)
- Kubernetes Volumes
- Persistent Volumes
- Scaling Persisiten Volumes with Claim Expansion

## 10. Exam Cheat Sheet

## Inspect the Pods
### Count the Number of Nodes That Are Ready to Run Normal Workloads
    kubectl get nodes
    kubectl describe node nodeName

### Retrieve Error Messages from a Container Log
    kubectl logs -n namespace nodeName -c proc | grep ERROR

### Find the Pod with a Label of app=auth in the Web Namespace That Is Utilizing the Most CPU
    kubectl top pod -n web --sort-by cpu --selector app=auth

## Expose the deployment
### Edit the web-frontend Deployment to Expose the HTTP Port
    kubectl edit deployment -n web web-frontend
In the Yaml File, port 80 is exposed

    spec:
      containers:
        - image: nginx:1.14.2
      ports:
        - containerPort: 80

### Create a Service to Expose the web-frontend Deployment's Pods Externally
    vi web-frontend-svc.yml
Define the service in the Yaml file:

    apiVersion: v1
    kind: Service
    metadata:
      name: web-frontend-svc
      namespace: web
    spec:
      type: NodePort
      selector:
        app: web-frontend
      ports:
      - protocol: TCP
        port: 80
        targetPort: 80
        nodePort: 30080
Don't forget to create the service by:
    
    kubectl create -f web-frontend-svc.yml

### Scale Up the Web Frontend Deployment
    kubectl scale deployment web-frontend -n web --replicas=5

### Create an Ingress That Maps to the New Service
    vi web-frontend-ingress.yml
Define an Ingress in the Yaml File:

    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: web-frontend-ingress
      namespace: web
    spec:
      rules:
      - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-frontend-svc
            port:
              number: 80

## Service Account and RBAC
### Create a Service Account
    kubectl create sa webautomation -n web

### Create a ClusterRole That Provides Read Access to Pods
    vi pod-reader.yml
Define the ClusterRole in the yaml file

    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      name: pod-reader
    rules:
    - apiGroups: [""]
      resources: ["pods"]
      verbs: ["get", "watch", "list"]

Creat the ClusterRole:

    kubectl create -f pod-reader.yml

### Bind the ClusterRole to the Service Account to Only Read Pods in the web Namespace
    vi rb-pod-reader.yml

Define the RoleBinding

    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      name: rb-pod-reader
      namespace: web
    subjects:
        - kind: ServiceAccount
          name: webautomation
    roleRef:
      kind: ClusterRole
      name: pod-reader
      apiGroup: rbac.authorization.k8s.io

Create the role binding:

    kubectl create -f rb-pod-reader.yml

