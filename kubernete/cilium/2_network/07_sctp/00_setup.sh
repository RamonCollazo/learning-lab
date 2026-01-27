# Setup using helm
helm repo add cilium https://helm.cilium.io/
helm upgrade --install cilium cilium/cilium --version v1.17.4 \
  --namespace kube-system \
  --set sctp.enabled=true \
  --set hubble.enabled=true \
  --set hubble.metrics.enabled="{dns,drop,tcp,flow,icmp,http}" \
  --set hubble.relay.enabled=true \
  --set hubble.ui.enabled=true \
  --set hubble.ui.service.type=NodePort \
  --set hubble.relay.service.type=NodePort
cilium status --wait
