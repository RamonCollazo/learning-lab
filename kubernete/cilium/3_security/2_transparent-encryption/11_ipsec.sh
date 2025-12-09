cilium install --version v1.17.4 \
  --set ipam.mode=cluster-pool \
  --set encryption.enabled=true \
  --set encryption.type=ipsec

cilium status --wait

cilium config view | grep enable-ipsec
