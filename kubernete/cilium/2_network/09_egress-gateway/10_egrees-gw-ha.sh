# Remove previous policy
kubectl delete ciliumegressgatewaypolicies outpost

# Apply new policy
kubectl apply -f egress-gw-policy-ha.yaml

# Test access
for i in $(seq 1 10); do
  kubectl exec -ti xwing -- \
    curl --max-time 2 http://172.18.0.7:8000
done
