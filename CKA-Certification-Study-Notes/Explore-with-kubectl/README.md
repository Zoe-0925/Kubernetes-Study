# Explore a Kubernetes cluster with kubectl

## kubectl get
``kubectl get <object type> <object name> -o <output> --sort-by <JSON path> -- selector <selector>``

## Search a list of volumes with sorting
    #Syntax:
    kubectl get pv -- {options}

    #Ex) Get a list of persisted volumes, sorted by capacity:
    kubectl get pv --sort-by=.spec.capacity.storage

## kubectl describe
``kubectl describe <object type> <object name>``

## kubectl create
For already created objects, this command will NOT work.
     ``kubectl create -f {file name}``

## kubectl apply
For already created objects, this command will override the values.
     ``kubectl apply -f {file name}``

## kubectl exec
Run commands inside a pod inside a namespace
     ``kubectl exec {pod name} -n {namespace name} -c {container name} --  {shell script}``

## Create a Deployment Using a Spec File
    kubectl apply -f /home/cloud_user/deployment.yml
    kubectl get deployments -n beebox-mobile
    kubectl get pods -n beebox-mobile

## Delete a service
``
kubectl delete service {service-name} -n {namespace-name}
``

## View resource usage
``
kubectl top pod --sort.by {json-path} -selector {selector}
``