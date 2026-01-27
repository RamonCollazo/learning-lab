for i in $(seq 1 10); do
  kubectl exec -ti xwing -- \
    curl --max-time 2 http://$OUTPOST2:8000
done
