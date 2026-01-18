kubectl get pods -o wide

# Verify resources
kubectl get ciliumendpoints.cilium.io

# Verify interface creation
kubectl exec -it client -- ip addr show

# Extract IP addr
SERVER_DEFAULT_IP=$(kubectl get pod server-default -o jsonpath='{.status.podIP}')
SERVER_JUPITER_IP=$(kubectl get pod server-jupiter -o jsonpath='{.status.podIP}')

echo "server-default IP: $SERVER_DEFAULT_IP"
echo "server-jupiter IP: $SERVER_JUPITER_IP"

# Validate connectivity
kubectl exec -it client -- ping -c 1 $SERVER_DEFAULT_IP

# Validate if server is reachable
kubectl exec -it client -- curl $SERVER_DEFAULT_IP/client-ip

# Validate connectivity to jupiter network
kubectl exec -it client -- ping -c 1 $SERVER_JUPITER_IP

# Validate reachable through jupiter
kubectl exec -it client -- curl $SERVER_JUPITER_IP/client-ip
