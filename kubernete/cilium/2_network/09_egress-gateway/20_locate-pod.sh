# Find zone of pod
kubectl get po xwing -o wide

# Check zone of node
kubectl get no kind-worker2 --show-labels |
  grep --color topology.kubernetes.io/zone=

# Find gatewayapi and egress of the zone
kubectl get isovalentegressgatewaypolicies outpost-ha -o yaml |
  yq '.status.groupStatuses'

# Verify egress traffic from pod leaves through local gateway
for i in $(seq 1 10); do
  kubectl exec -ti xwing -- \
    curl --max-time 2 http://172.18.0.8:8000
done
