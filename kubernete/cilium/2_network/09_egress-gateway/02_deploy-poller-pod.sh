# Deploy pods
kubectl run tiefighter \
  --labels "org=empire,class=tiefighter" \
  --image docker.io/tgraf/netperf
kubectl run xwing \
  --labels "org=alliance,class=xwing" \
  --image docker.io/tgraf/netperf

kubectl get pod --show-labels

# Reach out from containers
kubectl exec -ti tiefighter -- curl --max-time 2 http://$OUTPOST:8000

kubectl exec -ti xwing -- curl --max-time 2 http://$OUTPOST:8000
# Should fail because wrong IP
