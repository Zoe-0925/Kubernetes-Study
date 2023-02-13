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
- Capacity: 2Gi
- hostPath: myHostPath
- accessMode: readWriteOnce
- No storageClassName defined

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
- Storage: 2Gi
- accessMode: readWriteOnce
- No storageClassName
- Bound to the PV correctly

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


