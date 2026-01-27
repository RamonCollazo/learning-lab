kubectl exec -ti xwing -- \
  curl --max-time 2 http://172.18.0.7:8000
# Connection now accepted

kubectl exec -ti tiefighter -- \
  curl --max-time 2 http://172.18.0.7:8000
# Denied

# Deploy another alliance pod
kubectl run ywing \
  --labels "org=alliance,class=ywing" \
  --image docker.io/tgraf/netperf

kubectl get po ywing

# Test access outpost
kubectl exec -ti ywing -- \
  curl --max-time 2 http://172.18.0.7:8000
# Conncetion is accepted because of policy
