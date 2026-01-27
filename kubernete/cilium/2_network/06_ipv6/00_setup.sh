cilium install \
  --version 1.18.2 \
  --set kubeProxyReplacement=true \
  --set k8sServiceHost=kind-control-plane \
  --set k8sServicePort=6443 \
  --set ipv6.enabled=true

cilium status --wait

# Verify ipv6 enabled
cilium config view | grep ipv6

# Nodes should be ready state
kubectl get nodes

# Check PodCIDRs
kubectl describe nodes | grep PodCIDRs

# Activate hubble
cilium hubble enable --ui

cilium status --wait
