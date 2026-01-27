kubectl rollout status deploy sctp-deployment
kubectl expose deployment sctp-deployment --port=9999 --type=NodePort
kubectl get svc/sctp-deployment

# Get nodePort value
PORT=$(kubectl get svc/sctp-deployment -o jsonpath='{.spec.ports[0].nodePort}')
echo $PORT

# Get node IP
NODE_IP=$(kubectl get nodes -o jsonpath='{.items[?(@.metadata.name=="kind-worker")].status.addresses[?(@.type=="InternalIP")].address}')
echo $NODE_IP

# Install ncat
apt update
apt install -y ncat

# Run ncat
ncat --sctp $NODE_IP $PORT
