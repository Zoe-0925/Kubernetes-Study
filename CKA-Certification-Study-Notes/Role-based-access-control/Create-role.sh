#1. Test access by attempting to list pods as the dev user:
kubectl get pods -n beebox-mobile --kubeconfig dev-k8s-config
#We'll get an error message.

#2. Create a role spec file:
vi pod-reader-role.yml

#3. Add the following to the file:
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: beebox-mobile
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods", "pods/log"]
  verbs: ["get", "watch", "list"]

#Save and exit the file by pressing Escape followed by 
:wq

#4. Create the role:
kubectl apply -f pod-reader-role.yml