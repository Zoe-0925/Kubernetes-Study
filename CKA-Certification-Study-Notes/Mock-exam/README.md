# Mock Exam for Kubernetes CKA

## Question 1
### Write all context names into a file
    kubectl config get-contexts > /path_to_file

### Write a kubectl command to display the current context into a file
    echo 'kubectl config current-context' > /path_to_file.sh

### Write a non-kubectl command to display the current context into a file
    bash /path_to_file.sh

## Question 2
### Create a single pod
- Image Name: image_name
- Namespace: default 
- Pod Name: pod-1
- Container Name: pod1-container
- This pod should only be scheduled on a master node.

    kubectl run pod1 --image=image_name dry-run=client -o yaml > question2.yaml

Then open the yaml file and edit the variable names.
    apiVersion: 1
    kind: pod
    metadata:
      creationTimestamp: null
      labels: 
        run: pod1
      name: pod1
    spec:
      nodeName: cluster1-master1
      containers:
      - image: image_name
        name: pod1-container
        resources: {}
      dnsPolicy: ClusterFirst
      restartPolicy: Always
    status: {}

Then create the file:

    kubectl apply -f question2.yaml

### Explain why this pod is not scheduled to master by default
Because taints are applied to master by default.
The reason for this is to ensure that the control plane components, which are critical to the functioning of the cluster, are isolated from the workloads running in the cluster. 

## Question 3
### There are 2 pods named name-* in the namespace namespaceName. Scale the Pod down to 1 replica
    
    kubectl get all -n namespaceName

    kubectl get statefulsets -n namespaceName

    kubectl edit statefulsets -n namespaceName

    kubectl get pods -n namespaceName

## Question 4
### Create a single pod
Image: imageName
Configure a liveliness probe which simply runs true
Configure a readiness probe which does check if the url is reachable. Use

    wget -T2 -O-url

## Question 5
### Write a command into a file to list all pods sorted by age (metadata.creationTimestamp) - use kubectl sorting
    
    echo 'kubectl get pods -A --sort-by metadata.creationTimestamp' > file1.sh

    bash file1.sh

### Write a second comment into a file to list all pods sorted by field metadata.uid - use kubectl sorting
    
    echo 'kubectl get pods -A --sort-by metadata.uid' > file2.sh

    bash file2.sh

## Question 6
### Create a new PersistentVolume named pv-name.
Capacity: 2Gi
hostPath: myHostPath
accessMode: readWriteOnce
No storageClassName defined

    vi pv.yaml

    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: pv-name
    spec:
      capacity:
        storage: 2Gi
      volumeMode: Filesystem
      accessMode: 
        - readWriteOnce
      persistentVolumeReclaimPolicy: Recycle
      hostPath:
        path: myHostPath

### Create a new PersistentVolumeClaim in namespace namespaceName
Storage: 2Gi
accessMode: readWriteOnce
No storageClassName
Bound to the PV correctly

    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: myclaim
      namespace: namespaceName
    spec:
        accessModes:
          - ReadWriteOnce
        volumeMode: Filesystem
        resources:
          requests:
            storage: 2Gi

    kubectl apply -f pvc.yaml

### Create a deployment in namespacce namespaceName
- deployment name: deploymentName
- Mount that volume at path-to-mount
- Image for the pod: imageName

    kubectl create deployment deploymentName -n namespaceName --image imageName --dry-run=client -o yaml > question6.yaml

Dry run; print the corresponding API objects without creating them.

    vi question6.yaml

    #Add pv
    spec:
      volumes:
        - name: pv
          persistentVolumeClaim: 
            claimName: pvc

    #Add pvc
    containers: 
      - image: imageName
        name: httpd
        volumeMounts: 
          - mountPath: path-to-mount
            name: pvc

## Question 7
### Show node resource usage without a metrics server
    kubectl top node

### Show pod and their container resource usage without a metrics server
    kubectl top pod
    
## Question 8
### SSH into the master node
using `ssh cluster1-master1`
#### Check how the master components are installed/started on the master node.
Including
- kubelet
- kube-apiserver
- kube-scheduler
- kube-controller-manager
- etcd
- DNS
#### Write the findings into a file

## Question 9
### ssh into the master node
    ssh cluster2-master1

#### Temporarily stop the kube-scheduler
#### Allow the kube-scheduler to be restarted later if needed
    # Find the kube-scheduler.yaml file
    cd /etc/kubernetes/manifests

    cd ..
    pwd
    mv /etc/kubernetes/manifests/kube-scheduler.yaml /etc/kubernetes

### Create a single pod named manual-schedule of image imageName1.
#### Confirm it's created but not scheduled on any pod
#### Manually scehdule that pod on node. Make sure it's running.
    kubectl run manual-schedule --image==imageName --dry-run=client -o yaml > question9.yaml

Change the pod name and image name via the yaml file edit.

    kubectl apply -f question9.yaml

    # Verify
    kubectl get pods -w

### Start the kube-scheduler again and confirm it's running correctly by 
#### creating a second pod named manual-scheduled-pod of image imageName2.
#### Check the pod is running on cluster2-worker1
    kubectl run manual-schedule2 image=imageName2

    kubectl get pods -w

## Question 10
### Create a new Service Account processer in namespace namespaceName
### Create a role and role binding both named as processor as well
#### These should allow the new SA to only create Secrets and ConfigMap in the namespace
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: processer
      namespace: namespaceName

    ---

    apiVersion: v1
    kind: Role
    metadata:
      name: processer
      namespace: namespaceName
    rules:
    - apiGroups: [""]
      resources: ["secrets", "configmaps"]
      verbs: ["create"]

    --

    apiVersion: v1
    kind: RoleBinding
    metadata:
      name: processer
      namespace: namespaceName
    subjects:
    - kind: ServiceAccount
      name: processer
      apiGroup: ""
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: Role
      name: processer

## Question 11
### Create a daemonset named "ds-important"
image: imageName
label: id=ds-important
uuid: 1111
cpu: 10 milicore
memory: 10 mebibyte
Run on all nodes: master & worker

    apiVersion: apps/v1
    kind: DaemonSet
    metadata:
      name: ds-important
      namespace: namespaceName
      labels:
        id: ds-important
        uuid: 1111
    spec:
      tolerations:
      - key: node-role.kubernetes.io/master
        operator: Exists
        effect: NoSchedule
      containers:
      - name: ds-important
        image: imageName
        resources:
          requests:
            cpu: 10m
            memory: 10Mi

## Question 12
### Create a deployment named "deploy-important"
label: myLabel
replicas: 3
multi-container: 1 container with image1, another container with image 2

So, 3 nodes and 2 workers running. The 3rd node not running.
Simulate the daemonset with deployments and fixed replicas.

Containe 2 and 3 have command requirements.

The last empty container uses emptyDir

    kubectl run multi-container-playground --image imageName --dry-run=client -o yaml > question12.yaml

    apiVersion: batch/v1
    kind: Pod
    metadata:
      name: multi-container-playground
      creationTimestamp: null
      labels: 
        run: multi-container-playground
    spec:
      volumes:
      - name: cache volume
        emptyDir: {}
      containers: 
      - image: image1
        name: c1
        volumeMounts: 
        - mountPath: path1
          name: vm1

      - image: image2
        name: c2
        command: command2
        volumeMounts: 
        - mountPath: path2
          name: vm2
  
      - image: image3
        name: c3
        command: command3
        volumeMounts: 
        - mountPath: path3
          name: vm3

## Question 13
### Find out information about a cluster
How many master nodes are available?
How many worker nodes are available?
What is the service CIDR? (service-cluster-ip-range) . ---> An IP address
Which networking and (or CNI Plugin) is configured and where is the config file?
Which suffic will static pods have that run on cluster1-worker1?

    kubectl get nodes

    kubectl get pods -n namespaceName

Check all objects running inside the namespace.
Exlcude etcd, scheduler, proxy and you will find the CNI.

    kubectl describe pod podName -n namespaceName

    # Get configMap
    kubectl get cm -n namespaceName

## Question 14
### Use kubectl to find the latest events in the cluster, order by time
### Kill the kube proxy pod running on node cluster2-worker1 and write the events this caused
### Kill the containerd container of the kube-proxy Pod on node cluster2-worker1 and write the events

    kubectl get events

    # From the cheatsheet
    kubectl get events --sort-by=.metadata.creationTimestamp > file1.sh

    bash file1.sh

    # To kill the kube-proxy Pod on node cluster2-worker1
    # Delete the kube-proxy on cluster2-worker1
    kubectl get cm -n namespaceName

    kubectl delete cm kube-proxy -n namespaceName

    # Verify it's been killed
    kubectl get pods -n namespaceName

    # To kill the containerd container
    # First view containerd status
    sudo systemctl status containerd

    # Use the stop command to kill the containerd
    sudo systemctl stop containerd

## Question 15



