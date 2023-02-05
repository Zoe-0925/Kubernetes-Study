# Storage

## Kubernetes Volumes
- Volumes
- Volume Mounts: Reference volumes and provide the mount path
- Share volumes between containers
  - Use volume mounts to mount the same volume to multiple containers on the same pod
- Common Volume Types:
  - hostPath (directory)
  - emptyDir (dynamic storage - Used to send data between containers on the same pod)

## Persistent Volumes
- Created with spec on the amount of required storage
- If the PVC is not satisfied with the available storage, it remains in a pending state until additional storage is added.
- Storage Classes: to classify different storages for different business needs
- allowVolumeExpansion
- persistentVolumeReclaimPolicy: Decides what to do after the persistent volumes are deleted
- persistentVolumeClaim: Request for storage

## Scaling Persisiten Volumes with Claim Expansion
- Claim expansion = the process of increasing the size of an existing PVC after it has been created. 
- By updating the PVC definition with the new size and then reapplying it to the cluster. 
- The change in the size of the PVC triggers the resizing of the underlying PV, allowing the application to use the additional storage.
