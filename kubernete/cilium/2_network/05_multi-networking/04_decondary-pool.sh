# Deploy IP pool
kubectl apply -f 02_jupiter-ip-pool.yaml

# Deploy network config
kubectl apply -f 03_jupiterPodNetwork.yaml
