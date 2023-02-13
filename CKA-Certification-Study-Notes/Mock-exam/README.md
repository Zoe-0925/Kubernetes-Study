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
#### Image Name: image_name
#### Namespace: default 
#### Pod Name: pod-1
#### Container Name: pod1-container
#### This pod should only be scheduled on a master node.
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



