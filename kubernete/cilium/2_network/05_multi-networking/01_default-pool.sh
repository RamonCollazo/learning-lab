# Verify default IP pool
kubectl get ciliumpodippools.cilium.io default -o yaml | yq .spec

# Verify default network
kubectl get isovalentpodnetworks default -o yaml | yq .spec

# Verify /24 IP pools
kubectl get ciliumnode kind-worker2 kind-worker -o yaml |
  yq '.items[].spec.ipam.pools.allocated'
