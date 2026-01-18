cilium install \
  --version 1.17.4 \
  --namespace kube-system \
  --set kubeProxyReplacement=true \
  --set localRedirectPolicy=true \
  --set loadBalancer.serviceTopology=true

cilium status --wait

kubectl apply -f 02_tatooine.yaml
kubectl get -f 02_tatooine.yaml -o wide
