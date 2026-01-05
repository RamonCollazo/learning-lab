# Apply ssh rule
kubectl apply -f 07_ccnp-control-plane-ssh.yaml

# ssh test
for node in $(docker ps --format '{{.Names}}'); do
  echo "==== Testing connection to node $node ===="
  IP=$(docker inspect $node -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}')
  nc -vz -w2 $IP 22
done

# Check second terminal
