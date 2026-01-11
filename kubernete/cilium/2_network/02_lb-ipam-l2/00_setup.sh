cilium install \
  --version v1.17.4 \
  --set kubeProxyReplacement=true \
  --set k8sServiceHost="kind-control-plane" \
  --set k8sServicePort=6443 \
  --set l2announcements.enabled=true \
  --set l2announcements.leaseDuration="3s" \
  --set l2announcements.leaseRenewDeadline="1s" \
  --set l2announcements.leaseRetryPeriod="500ms" \
  --set devices="{eth0,net0}" \
  --set externalIPs.enabled=true \
  --set operator.replicas=2

cilium hubble enable --ui

cilium status --wait

cilium config view | grep enable-l2-announcements
