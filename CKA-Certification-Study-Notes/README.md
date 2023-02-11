# Certified Kubernetes Administrator (CKA) Study Notes

## Kubernetes Architecture
https://devopscube.com/kubernetes-architecture-explained/

## 1. Kubernetes Cluster Setup Using Kubeadm
Tutorial in [Kubernetes Cluster Setup Using Kubeadm](https://github.com/Zoe-0925/Kubernetes-Study/tree/main/CKA-Certification-Study-Notes/Kubernetes%20Cluster%20Setup%20Using%20Kubeadm)
- Startup configurations
- Install kubelet, kubectl, and kubeadm
- Create a small cluster with 1 control plane and 2 worker nodes

Useful Link
https://devopscube.com/setup-kubernetes-cluster-kubeadm/

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
Define the service via web-frontend-svc.yml

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
Define an Ingress via web-frontend-ingress.yml

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
Define the ClusterRole via pod-reader.yml

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
Define the RoleBinding via rb-pod-reader.yml

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

## Backup and Restore
### Back Up the etcd Data
    ssh etcd1

    ETCDCTL_API=3 etcdctl snapshot save /home/cloud_user/etcd_backup.db \
    --endpoints=https://etcd1:2379 \
    --cacert=/home/cloud_user/etcd-certs/etcd-ca.pem \
    --cert=/home/cloud_user/etcd-certs/etcd-server.crt \
    --key=/home/cloud_user/etcd-certs/etcd-server.key

### Restore the etcd Data
    sudo systemctl stop etcd

    sudo rm -rf /var/lib/etcd

    sudo ETCDCTL_API=3 etcdctl snapshot restore /home/cloud_user/etcd_backup.db \
    --initial-cluster etcd-restore=https://etcd1:2380 \
    --initial-advertise-peer-urls https://etcd1:2380 \
    --name etcd-restore \
    --data-dir /var/lib/etcd

    # Set the DB ownership
    sudo chown -R etcd:etcd /var/lib/etcd

    sudo systemctl start etcd

    ETCDCTL_API=3 etcdctl get cluster.name \
    --endpoints=https://etcd1:2379 \
    --cacert=/home/cloud_user/etcd-certs/etcd-ca.pem \
    --cert=/home/cloud_user/etcd-certs/etcd-server.crt \
    --key=/home/cloud_user/etcd-certs/etcd-server.key

## Upgradation
Useful Link
https://devopscube.com/upgrade-kubernetes-cluster-kubeadm/

### Upgrade All Kubernetes Components on the Control Plane Node
    sudo apt-get update && \
    sudo apt-get install -y --allow-change-held-packages kubeadm=1.22.2-00

    kubectl drain acgk8s-control --ignore-daemonsets

    sudo kubeadm upgrade plan v1.22.2

    sudo kubeadm upgrade apply v1.22.2

    sudo apt-get update && \
    sudo apt-get install -y --allow-change-held-packages kubelet=1.22.2-00 kubectl=1.22.2-00

    sudo systemctl daemon-reload

    sudo systemctl restart kubelet

    kubectl uncordon acgk8s-control

### Upgrade All Kubernetes Components on the Worker Nodes
    kubectl drain workerName --ignore-daemonsets --force

    ssh workerName

    sudo apt-get update && \
    sudo apt-get install -y --allow-change-held-packages kubeadm=1.22.2-00

    sudo kubeadm upgrade node

    sudo apt-get update && \
    sudo apt-get install -y --allow-change-held-packages kubelet=1.22.2-00 kubectl=1.22.2-00

    sudo systemctl daemon-reload

    sudo systemctl restart kubelet

    kubectl uncordon workerName

## Label
### Create a Pod That Will Only Be Scheduled on Nodes with a Specific Label
    kubectl label nodes acgk8s-worker2 disk=fast

Specify the pod via fast-nginx.yml

    apiVersion: v1
    kind: Pod
    metadata:
      name: fast-nginx
      namespace: dev
    spec:
      nodeSelector:
        disk: fast
      containers:
      - name: nginx
        image: nginx

Create the file

    kubectl create -f fast-nginx.yml

    kubectl get pod fast-nginx -n dev -o wide

## PersistentVolume
### Create a PersistentVolume
Specify the local disk via localdisk.yml

    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: localdisk
    provisioner: kubernetes.io/no-provisioner
    allowVolumeExpansion: true

Create the local disk

    kubectl create -f localdisk.yml

Specify the persisten volume via host-storage-pv.yml

    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: host-storage-pv
    spec:
      storageClassName: localdisk
      persistentVolumeReclaimPolicy: Recycle
      capacity:
        storage: 1Gi
      accessModes:
        - ReadWriteOnce
      hostPath:
        path: /etc/data

Create the persistent volume

    kubectl create -f host-storage-pv.yml

Check the status of the persistent volume

    kubectl get pv host-storage-pv

### Create a Pod That Uses the PersistentVolume for Storage
Specify the PersistentVolumeClaim via host-storage-pvc.yml

    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: host-storage-pvc
      namespace: auth
    spec:
      storageClassName: localdisk
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 100Mi

Create the PersistentVolumeClaim

    kubectl create -f host-storage-pvc.yml

Check the status of the PersistentVolumeClaim and Verify that the claim is bound to the volume

    kubectl get pv
    kubectl get pvc -n auth

Specify the pod that uses the persistent volume via pv-pod.yml

    apiVersion: v1
    kind: Pod
    metadata:
      name: pv-pod
      namespace: auth
    spec:
      containers:
      - name: busybox
        image: busybox
        command: ['sh', '-c', 'while true; do echo success > /output/output.log; sleep 5; done']
        volumeMounts:
        - name: pv-storage
          mountPath: /output
      volumes:
      - name: pv-storage
        persistentVolumeClaim:
          claimName: host-storage-pvc

Create the pod

    kubectl create -f pv-pod.yml

### Expand the PersistentVolumeClaim
    kubectl edit pvc host-storage-pvc -n auth

## Network Policy Config
### Create a Networkpolicy That Denies All Access to the Maintenance Pod
Check the foo namespace and Check the maintenance pod's labels
    kubectl get pods -n foo
    kubectl describe pod maintenance -n foo

Specify the network policy via np-maintenance.yml

    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: np-maintenance
      namespace: foo
    spec:
      podSelector:
        matchLabels:
          app: maintenance
      policyTypes:
      - Ingress
      - Egress

Create the network policy for deny-all-traffic

    kubectl create -f np-maintenance.yml

### Create a Networkpolicy That Allows All Pods in the users-backend Namespace to Communicate with Each Other Only on a Specific Port
Label the users-backend namespace
    kubectl label namespace users-backend app=users-backend

Specify the network policy via np-users-backend-80.yml
    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: np-users-backend-80
      namespace: users-backend
    spec:
      podSelector: {}
      policyTypes:
      - Ingress
      ingress:
      - from:
        - namespaceSelector:
            matchLabels:
              app: users-backend
        ports:
        - protocol: TCP
          port: 80

Create the network policy

    kubectl create -f np-users-backend-80.yml

## Container and Pod config
### Create a Multi-Container Pod
create a Multi-Container Pod via multi.yml

    apiVersion: v1
    kind: Pod
    metadata:
      name: multi
      namespace: baz
    spec:
      containers:
      - name: nginx
        image: nginx
      - name: redis
        image: redis

Create and verify

    kubectl create -f multi.yml
    kubectl get pods -n baz

## Create a Pod Which Uses a Sidecar to Expose the Main Container's Log File to Stdout
Create the pod via logging-sidecar.yml

    apiVersion: v1
    kind: Pod
    metadata:
      name: logging-sidecar
      namespace: baz
    spec:
      containers:
      - name: busybox1
        image: busybox
        command: ['sh', '-c', 'while true; do echo Logging data > /output/output.log; sleep 5; done']
        volumeMounts:
        - name: sharedvol
          mountPath: /output
      - name: sidecar
        image: busybox
        command: ['sh', '-c', 'tail -f /input/output.log']
        volumeMounts:
        - name: sharedvol
          mountPath: /input
      volumes:
      - name: sharedvol
        emptyDir: {}

Create and verify

    kubectl create -f logging-sidecar.yml
    kubectl get pods -n baz
    kubectl logs logging-sidecar -n baz -c sidecar

