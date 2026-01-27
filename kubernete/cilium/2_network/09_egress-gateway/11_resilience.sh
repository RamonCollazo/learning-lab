# Remove one egress node
kubectl label node kind-worker3 egress-gw-

# Test access
for i in $(seq 1 10); do
  kubectl exec -ti xwing -- \
    curl --max-time 2 http://172.18.0.7:8000
done
# Traffic flow continues

# Add label again
kubectl label node kind-worker3 egress-gw=true

# Test traffic again
for i in $(seq 1 10); do
  kubectl exec -ti xwing -- \
    curl --max-time 2 http://172.18.0.7:8000
done
