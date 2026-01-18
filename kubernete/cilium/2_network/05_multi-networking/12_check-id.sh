# Check identity ID of client endpoint
kubectl get cep client -o yaml | yq .status.identity

# Check identity ID of client-cil1 endpoint
kubectl get cep client-cil1 -o yaml | yq .status.identity
