# On a second terminal window:

kubectl run -ti --rm sub --image nicolaka/netshoot -- \
  socat UDP4-RECVFROM:6666,reuseaddr,ip-add-membership=225.0.0.11:0.0.0.0,fork -

# On main terminal window:

kubectl get po sub -o wide

# Get name of node where pods are scheduled

NODE=$(kubectl get po sub -o jsonpath='{.spec.nodeName}')
echo $NODE

# Get name of cilium agent

CILIUM_POD=$(kubectl -n kube-system get po -l k8s-app=cilium --field-selector spec.nodeName=$NODE -o name)
echo $CILIUM_POD

# Check subscriber

kubectl exec $CILIUM_POD -n kube-system -c cilium-agent -- \
  cilium bpf multicast subscriber list all

# Check on different agent

OTHER_CILIUM_POD=$(kubectl -n kube-system get po -l k8s-app=cilium -o json | jq -r ".items[] | select(.spec.nodeName!=\"$NODE\").metadata.name" | head -n1)
echo $OTHER_CILIUM_POD

# Check subscription again

kubectl exec $OTHER_CILIUM_POD -n kube-system -c cilium-agent -- \
  cilium bpf multicast subscriber list all

# Agent is running on a different node, IP add is also marked as a Remote Node
