# A bgp router must be used

cilium install \
  --version v1.18.2 \
  --set ipam.mode=kubernetes \
  --set routingMode=native \
  --set ipv4NativeRoutingCIDR="10.0.0.0/8" \
  --set bgpControlPlane.enabled=true \
  --set k8s.requireIPv4PodCIDR=true

cilium status --wait

cilium config view | grep enable-bgp
