# Services

## Service Types
- ClusterIP: expose apps inside the cluster
  - Use this if the client is another pod
- NodePort: expose apps outside the cluster
- LoadBalancer: expose outside + cloud load balancer
- ExternalName

## Discover Services with DNS
- Service DNS Names: Assign DNS names to services
- A valid Service DNS Name can reach any namespace within the client

## Managing Acess from Outside with Kubernetes Ingress
- Ingress Controller: Can install 1 or many
- Ingress defines routing rules
  - Each rule has a set of paths, each with a backend
- Can use Named Port to specify where to route to