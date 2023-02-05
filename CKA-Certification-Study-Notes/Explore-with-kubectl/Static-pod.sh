#1. On the worker node, Create a static pod manifest file
sudo vi /etc/kubernetes/manifests/beebox-diagnostic.yml

#2. Paste the contents inside the Static-pod-manifest.yaml

#3. Restart kubelet to start the static pod
sudo systemctl restart kubelet

#4. On the Control Plane, Check the status of your static Pod
kubectl get pods

#5. Attempt to delete the static Pod using the k8s API:
kubectl delete pod beebox-diagnostic-k8s-worker1

#6. Check the status of the Pod:
kubectl get pods

#We'll see the Pod was immediately re-created, since it is only a mirror Pod created by the worker kubelet to represent the static Pod.