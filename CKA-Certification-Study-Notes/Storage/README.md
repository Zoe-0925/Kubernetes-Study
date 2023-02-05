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
- Storage Classes: to classify different storages for different business needs
- allowVolumeExpansion
- persistentVolumeReclaimPolicy: Decides what to do after the persistent volumes are deleted
- persistentVolumeClaim: Request for storage

