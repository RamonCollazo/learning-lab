kubectl exec daemonsets/cilium -n kube-system -c cilium-agent -- \
  cilium bpf multicast group list

kubectl exec daemonsets/cilium -n kube-system -c cilium-agent -- \
  cilium bpf multicast subscriber list all
