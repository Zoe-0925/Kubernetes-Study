#1. Create the RoleBinding spec file:
vi pod-reader-rolebinding.yml

#2. Add the following to the file:
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: pod-reader
  namespace: beebox-mobile
subjects:
- kind: User
  name: dev
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io

#Save and exit the file by pressing Escape followed by 
:wq

#3. Create the RoleBinding:
kubectl apply -f pod-reader-rolebinding.yml

#4. Test access again to verify you can successfully list pods:
kubectl get pods -n beebox-mobile --kubeconfig dev-k8s-config

#This time, we should see a list of pods (there's just one).

#5. Verify the dev user can read pod logs:
kubectl logs beebox-auth -n beebox-mobile --kubeconfig dev-k8s-config

#We'll get an Auth processing... message.

#6. Verify the dev user cannot make changes by attempting to delete a pod:
kubectl delete pod beebox-auth -n beebox-mobile --kubeconfig dev-k8s-config

#We'll get an error, which is what we want.