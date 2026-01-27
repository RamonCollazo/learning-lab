# Apply topology
kubectl label node kind-worker topology.kubernetes.io/zone=east
kubectl label node kind-worker3 topology.kubernetes.io/zone=east

kubectl label node kind-worker2 topology.kubernetes.io/zone=west
kubectl label node kind-worker4 topology.kubernetes.io/zone=west

# Verify lables
kubectl get no --show-labels |
  grep --color topology.kubernetes.io/zone=

# Inspect values
kubectl explain isovalentegressgatewaypolicies.spec.azAffinity

# Deploy updated policy
kubectl apply -f 17_egress-gw-policy-ha.yaml
