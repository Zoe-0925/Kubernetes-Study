# Obtain logs from a pod
kubectl logs -n namespace podname -c proc

# Obtain error logs from a pod
kubectl logs -n namespace podname -c proc | grep ERROR
