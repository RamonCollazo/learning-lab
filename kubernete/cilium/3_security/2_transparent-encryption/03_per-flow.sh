cilium install --version v1.17.4 \
  --set encryption.enabled=true \
  --set encryption.type=wireguard \
  --set enterprise.encryption.policy.enabled=true \
  --set enterprise.encryption.policy.fallbackBehavior=plaintext  

cilium status --wait
