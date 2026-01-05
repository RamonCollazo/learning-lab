# Install cilium

cilium install \
  --version 1.18.2 \
  --set hostFirewall.enabled=true \
  --set bpf.monitorAggregation=none

# Activate hubble

cilium hubble enable
cilium status --wait
cilium config view | grep host-firewall
