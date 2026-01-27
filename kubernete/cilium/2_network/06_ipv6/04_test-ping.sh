# Check pods deployed successfully
kubectl describe pod pod-worker | grep -A 2 IPs
kubectl describe pod pod-worker2 | grep -A 2 IPs

# Get ipv6 address from worker2
IPv6=$(kubectl get pod pod-worker2 -o jsonpath='{.status.podIPs[1].ip}')
echo $IPv6

# Ping from worker to worker2
kubectl exec -it pod-worker -- ping6 -c 5 $IPv6
