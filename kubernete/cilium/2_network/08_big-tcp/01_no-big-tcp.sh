# Verify Big TCP is disabled
cilium config view | grep ipv4-big-tcp

# Deploy netperf client
kubectl apply -f https://raw.githubusercontent.com/NikAleksandrov/cilium/42b93676d85783aa167105a91e44078ce6731297/test/bigtcp/netperf.yaml

kubectl get pods

# Get ipv4 address
NETPERF_SERVER=$(kubectl get pod netperf-server -o jsonpath='{.status.podIPs}' | jq -r -c '.[].ip | select(contains(":") == false)')
echo $NETPERF_SERVER

# Start performance test
kubectl exec netperf-client -- \
  netperf -t TCP_RR -H ${NETPERF_SERVER} -- \
  -r80000:80000 -O MIN_LATENCY,P90_LATENCY,P99_LATENCY,THROUGHPUT
