kubectl apply -f 04_netshoot-ds.yaml
kubectl rollout status ds/netshoot -w
