# Use `CiliumClusterwideNetworkPolicy` to implement rules

kubectl apply -f 03_ccnp-control-plane-apiserver.yaml
kubectl apply -f 04_ccnp-default-deny.yaml

kubectl get ccnp
