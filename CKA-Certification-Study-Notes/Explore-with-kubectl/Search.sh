#Find the Pod with a Label of app=auth in the Web Namespace That Is Utilizing the Most CPU
kubectl top pod -n web --sort-by cpu --selector app=auth