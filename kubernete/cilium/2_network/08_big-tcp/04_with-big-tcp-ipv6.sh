# Enable big tcp for ipv6
cilium config set enable-ipv6-big-tcp true

cilium config view | grep ipv6-big-tcp

cilium status --wait

# Verify GSO settings on node
docker exec kind-worker ip -d -j link show dev eth0 |
  jq -c '.[0].gso_max_size'
# Expect a reply of 196608

# Redeploy pods for GSO to be reflected
kubectl delete -f https://raw.githubusercontent.com/NikAleksandrov/cilium/42b93676d85783aa167105a91e44078ce6731297/test/bigtcp/netperf.yaml
kubectl apply -f https://raw.githubusercontent.com/NikAleksandrov/cilium/42b93676d85783aa167105a91e44078ce6731297/test/bigtcp/netperf.yaml

# Check GSO on netperf pods
kubectl exec netperf-server -- ip -d -j link show dev eth0 | jq -c '.[0].gso_max_size'
kubectl exec netperf-client -- ip -d -j link show dev eth0 | jq -c '.[0].gso_max_size'

# Get netperf-server ipv6
NETPERF_SERVER=$(kubectl get pod netperf-server -o jsonpath='{.status.podIPs}' | jq -r -c '.[].ip | select(contains(":") == true)')
echo $NETPERF_SERVER

# Run test
kubectl exec netperf-client -- \
  netperf -t TCP_RR -H ${NETPERF_SERVER} -- \
  -r80000:80000 -O MIN_LATENCY,P90_LATENCY,P99_LATENCY,THROUGHPUT
