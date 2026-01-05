# Bastion host access

docker exec -ti kind-control-plane bash

# Test ssh
for node in $(kubectl get node -o name); do
  echo "==== Testing connection to node $node ===="
  IP=$(kubectl get $node -o jsonpath='{.status.addresses[0].address}')
  nc -vz -w2 $IP 22
done

# Check on second terminal window
