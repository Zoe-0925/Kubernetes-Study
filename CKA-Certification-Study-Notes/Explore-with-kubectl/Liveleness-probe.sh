#1. Add a liveness probe - Same as the ones in the helm files
#Save and exit the file by pressing Escape followed by :wq.

#2. Delete the pod:
kubectl delete pod beebox-shipping-data

#3. Re-create the pod to apply the changes:
kubectl apply -f beebox-shipping-data.yml

#4. Check the pod status
kubectl get pods -o wide

#5. If you wait a minute or so and check again, you should see the pod is being restarted whenever the application crashes.

#6. Check the http response from the pod again (it will have a new IP address since we re-created it):
kubectl exec busybox -- curl <beebox-shipping-data_IP>:8080
