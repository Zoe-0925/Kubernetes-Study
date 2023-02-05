#1. Generate an htpasswd file:
htpasswd -c .htpasswd user

#2.Create a password

#3. View the file's contents:
cat .htpasswd

#4. Create a Secret containing the htpasswd data:
kubectl create secret generic nginx-htpasswd --from-file .htpasswd

#5. Delete the .htpasswd file:
rm .htpasswd