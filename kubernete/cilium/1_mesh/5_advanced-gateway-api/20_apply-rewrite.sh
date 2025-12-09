GATEWAY=$(kubectl get gateway cilium-gw -o jsonpath='{.status.addresses[0].value}')
echo $GATEWAY

kubectl apply -f ./19_http-rewrite-route.yaml

curl -s http://$GATEWAY/prefix/one | jq
