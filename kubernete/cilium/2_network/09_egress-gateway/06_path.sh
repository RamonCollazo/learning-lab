# Look which node is running
kubectl get po xwing -o wide

# Find Cilium pod on the node
kubectl -n kube-system get po -l k8s-app=cilium \
  --field-selector spec.nodeName=kind-worker2

# Inspect egress data
kubectl -n kube-system exec -ti pod/cilium-7h2kq -c cilium-agent -- \
  cilium bpf egress list

# Get IP form outpost
GATEWAY_IP=$(kubectl -n kube-system exec -ti pod/cilium-7h2kq -c cilium-agent -- cilium bpf egress list -o json | jq -r '.[0].GatewayIP')
echo $GATEWAY_IP

# Find the node it is attached to
EGRESS_NODE=$(kubectl get no -o json | jq -r ".items[] | select(.status.addresses[].address==\"$GATEWAY_IP\").metadata.name")
echo $EGRESS_NODE

# Inspect egress policy
CILIUM_POD=$(kubectl -n kube-system get po -l k8s-app=cilium --field-selector spec.nodeName=$EGRESS_NODE -o name)
kubectl -n kube-system exec -ti $CILIUM_POD -c cilium-agent -- \
  cilium bpf egress list
