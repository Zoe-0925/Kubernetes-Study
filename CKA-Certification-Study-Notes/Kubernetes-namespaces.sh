#1. Create a namespace in the cluster called dev:
kubectl create namespace dev

#2. List the current namespaces:
kubectl get namespace

#3. Save the namespaces list to a file:
kubectl get namespace > /home/cloud_user/namespaces.txt

#4. Verify the list saved to the file:
cat namespaces.txt
#We should see the list of namespaces.