# Explore a Kubernetes cluster with kubectl

## Search a list of volumes with sorting
    Syntax:
    ``kubectl get pv -- {options}``
    Ex) Get a list of persisted volumes, sorted by capacity:
    ``kubectl get pv --sort-by=.spec.capacity.storage``

## Run commands inside a pod inside a namespace
``kubectl exec {pod-name} -n {namespace-name} -- {shell script}``

## Create a Deployment Using a Spec File
    ``kubectl apply -f /home/cloud_user/deployment.yml``
    ``kubectl get deployments -n beebox-mobile``
    ``kubectl get pods -n beebox-mobile``

## Delete a service
``
kubectl delete service {service-name} -n {namespace-name}
``
