# Big TCP disabled on ipv6
cilium config view | grep ipv6-big-tcp

# Check GSO (Generic Segmentation Offload)
docker exec kind-worker ip -d -j link show dev eth0 | jq -c '.[0].gso_max_size'

# Deploy netperf
kubectl apply -f https://raw.githubusercontent.com/NikAleksandrov/cilium/42b93676d85783aa167105a91e44078ce6731297/test/bigtcp/netperf.yaml

kubectl get pods

# Check GSO for netperf
kubectl exec netperf-server -- \
  ip -d -j link show dev eth0 |
  jq -c '.[0].gso_max_size'

# Get ipv6 of netperf-server
kubectl exec netperf-client -- \
  netperf -t TCP_RR -H ${NETPERF_SERVER} -- \
  -r80000:80000 -O MIN_LATENCY,P90_LATENCY,P99_LATENCY,THROUGHPUT

# Run test
kubectl exec netperf-client -- \
  netperf -t TCP_RR -H ${NETPERF_SERVER} -- \
  -r80000:80000 -O MIN_LATENCY,P90_LATENCY,P99_LATENCY,THROUGHPUT
