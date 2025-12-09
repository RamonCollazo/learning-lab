cilium install --version v1.17.4 \
  --set ipam.mode=cluster-pool \
  --set encryption.enabled=true \
  --set encryption.type=wireguard \
  --set encryption.nodeEncryption=true

cilium status --wait
