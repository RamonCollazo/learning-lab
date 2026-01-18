# Get IPs
SERVER_DEFAULT_IP=$(kubectl get pod server-default -o jsonpath='{.status.podIP}')
SERVER_JUPITER_IP=$(kubectl get pod server-jupiter -o jsonpath='{.status.podIP}')
echo "server-default IP: $SERVER_DEFAULT_IP"
echo "server-jupiter IP: $SERVER_JUPITER_IP"

# Validate reachability
kubectl exec -it client -- curl $SERVER_DEFAULT_IP/public

# Validate connectivity
kubectl exec -it client -- ping -c 1 -W 1 $SERVER_DEFAULT_IP
# Shouldn't be successful

# Validate reachability in jupiter network
kubectl exec -it client -- curl --max-time 2 $SERVER_JUPITER_IP/public
# Shouldn't be successful

# Validate connectivity in jupiter network
kubectl exec -it client -- ping -c 1 -W 1 $SERVER_JUPITER_IP
# Ping should be successful
