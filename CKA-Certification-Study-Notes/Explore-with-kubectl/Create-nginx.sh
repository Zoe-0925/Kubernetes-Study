#1. Create pod.yml:
vi pod.yml

#2. Enter the following to create the pod and mount the Nginx config and htpasswd Secret data:
#The contents are inside the nginx-config-for-htpasswd.yaml

#3. View the existing ConfigMap:
kubectl get cm

#4. Get more info about nginx-config:
kubectl describe cm nginx-config

#5. Create the pod:
kubectl apply -f pod.yml

#6. Check the status of your pod and get its IP address:
kubectl get pods -o wide

#Its IP address will be listed once it has a Running status. 

#7. Within the existing busybox pod, without using credentials, verify everything is working:
kubectl exec busybox -- curl <NGINX_POD_IP>

#We'll see HTML for the 401 Authorization Required page — which is expected

#8. Run the same command again using credentials (including the password you created at the beginning of the lab) to verify everything is working:
kubectl exec busybox -- curl -u user:<PASSWORD> <NGINX_POD_IP>

#This time, we'll see the Welcome to nginx! page HTML.