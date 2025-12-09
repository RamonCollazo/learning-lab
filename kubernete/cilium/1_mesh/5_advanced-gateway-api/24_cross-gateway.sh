# Make sure ns are are implemented

kubectl get ns --show-labels \
  infra-ns careers product hr

kubectl apply -f 23_cross-namespace.yaml

GATEWAY=$(kubectl get gateway shared-gateway -n infra-ns -o jsonpath='{.status.addresses[0].value}')
echo $GATEWAY

curl -s -o /dev/null -w "%{http_code}\n" http://$GATEWAY/product

curl -s -o /dev/null -w "%{http_code}\n" http://$GATEWAY/careers

curl -s -o /dev/null -w "%{http_code}\n" http://$GATEWAY/hr

echo "Product HTTPRoute Status"
kubectl get httproutes.gateway.networking.k8s.io -n product -o jsonpath='{.items[0].status.parents[0].conditions[0]}' | jq
echo "Careers HTTPRoute Status"
kubectl get httproutes.gateway.networking.k8s.io -n careers -o jsonpath='{.items[0].status.parents[0].conditions[0]}' | jq
echo "HR HTTPRoute Status"
kubectl get httproutes.gateway.networking.k8s.io -n hr -o jsonpath='{.items[0].status.parents[0].conditions[0]}' | jq
