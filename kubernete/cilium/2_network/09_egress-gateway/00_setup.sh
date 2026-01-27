# Setup:
#
# kubectl get nodes
# NAME                 STATUS     ROLES           AGE     VERSION
# kind-control-plane   NotReady   control-plane   6m55s   v1.33.1
# kind-worker          NotReady   <none>          6m43s   v1.33.1
# kind-worker2         NotReady   <none>          6m44s   v1.33.1
# kind-worker3         NotReady   <none>          6m44s   v1.33.1
# kind-worker4         NotReady   <none>          6m43s   v1.33.1

# Prevent workload to be scheduled on nodes
kubectl taint node kind-worker3 egress-gw:NoSchedule
kubectl taint node kind-worker4 egress-gw:NoSchedule

# Add labels
kubectl label nodes kind-worker3 egress-gw=true
kubectl label nodes kind-worker4 egress-gw=true

# Verify kind network
docker network inspect -f '{{range.IPAM.Config}}{{.Subnet}}, {{end}}' kind

# Add dummy interface
docker exec kind-worker3 ip link add net0 type dummy
docker exec kind-worker3 ip a add 172.18.0.42/16 dev net0
docker exec kind-worker3 ip link set net0 up

docker exec kind-worker4 ip link add net0 type dummy
docker exec kind-worker4 ip a add 172.18.0.43/16 dev net0
docker exec kind-worker4 ip link set net0 up

# Install Cilium
cilium install \
  --version 1.18.2 \
  --set kubeProxyReplacement=true \
  --set egressGateway.enabled=true \
  --set bpf.masquerade=true \
  --set l7Proxy=false \
  --set devices="{eth+,net+}"

cilium status --wait

cilium config view | grep egress-gateway

# Verify workers
CILIUM3_POD=$(kubectl -n kube-system get po -l k8s-app=cilium --field-selector spec.nodeName=kind-worker3 -o name)
kubectl -n kube-system exec -ti $CILIUM3_POD -- cilium status

CILIUM4_POD=$(kubectl -n kube-system get po -l k8s-app=cilium --field-selector spec.nodeName=kind-worker4 -o name)
kubectl -n kube-system exec -ti $CILIUM4_POD -- cilium status
# Check the `KubeProxyReplacement` and `Masquerading` fields
