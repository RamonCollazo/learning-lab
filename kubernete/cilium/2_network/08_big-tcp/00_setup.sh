# Kernel upgrade
wget https://raw.githubusercontent.com/pimlie/ubuntu-mainline-kernel.sh/master/ubuntu-mainline-kernel.sh
chmod +x ubuntu-mainline-kernel.sh
mv ubuntu-mainline-kernel.sh /usr/local/bin/
ubuntu-mainline-kernel.sh -c
ubuntu-mainline-kernel.sh -i v6.4.0

reboot

# Verify kernel has ben updated
uname -ar

# For a kind cluster:
# cat /etc/kind/nocni_2workers_dual.yaml
# ---
# kind: Cluster
# apiVersion: kind.x-k8s.io/v1alpha4
# nodes:
# - role: control-plane
# - role: worker
# - role: worker
# networking:
#   ipFamily: dual
#   disableDefaultCNI: true
kind create cluster --config "/etc/kind/nocni_2workers_dual.yaml"

# Install Cilium
cilium install --version v1.17.4 \
  --set routingMode=native \
  --set bpf.masquerade=true \
  --set ipv6.enabled=true \
  --set enableIPv6Masquerade=false \
  --set kubeProxyReplacement=true \
  --set ipam.mode=kubernetes \
  --set nodePort.enabled=true \
  --set autoDirectNodeRoutes=true \
  --set hostLegacyRouting=false \
  --set ipv4NativeRoutingCIDR="10.0.0.0/8" \
  --set enableIPv6BIGTCP=false \
  --set enableIPv4BIGTCP=false
# Big TCP will not be enabled for now

cilium status --wait

kubectl get nodes
