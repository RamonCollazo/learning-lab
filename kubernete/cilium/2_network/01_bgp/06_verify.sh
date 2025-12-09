SRC_POD=$(kubectl get pods -o wide | grep "kind-worker " | awk '{ print($1); }')
DST_IP=$(kubectl get pods -o wide | grep worker3 | awk '{ print($6); }')
kubectl exec -it $SRC_POD -- ping -c 10 $DST_IP
