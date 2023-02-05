#Set a Restart Policy to Restart the Container When It Is Down

#1. Find the pod that needs to be modified:
kubectl get pods -o wide

#2. Take note of the beebox-shipping-data pod's IP address.

#3. Use the busybox pod to make a request to the pod to see if it is working:
kubectl exec busybox -- curl <beebox-shipping-data_ IP>:8080

#We will likely get an error message.

#4. Get the pod's YAML descriptor:
kubectl get pod beebox-shipping-data -o yaml > beebox-shipping-data.yml

#5. Open the file:
vi beebox-shipping-data.yml

#6. Set the restartPolicy to Always: