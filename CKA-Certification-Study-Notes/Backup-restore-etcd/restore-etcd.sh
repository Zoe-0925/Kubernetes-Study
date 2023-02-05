#1. Restore the etcd data from the backup 
#(this command spins up a temporary etcd cluster, saving the data from the backup file to a new data directory in the same location where the previous data directory was):
sudo ETCDCTL_API=3 etcdctl snapshot restore /home/cloud_user/etcd_backup.db \
  --initial-cluster etcd-restore=https://10.0.1.101:2380 \
  --initial-advertise-peer-urls https://10.0.1.101:2380 \
  --name etcd-restore \
  --data-dir /var/lib/etcd

#2. Set ownership on the new data directory:
sudo chown -R etcd:etcd /var/lib/etcd

#3. Start etcd:
sudo systemctl start etcd

#4. Verify the restored data is present by looking up the value for the key cluster.name again:
ETCDCTL_API=3 etcdctl get cluster.name \
  --endpoints=https://10.0.1.101:2379 \
  --cacert=/home/cloud_user/etcd-certs/etcd-ca.pem \
  --cert=/home/cloud_user/etcd-certs/etcd-server.crt \
  --key=/home/cloud_user/etcd-certs/etcd-server.key

#The returned value should be beebox.