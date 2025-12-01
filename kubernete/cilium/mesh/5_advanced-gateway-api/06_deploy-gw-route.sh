kubectl apply -f ./04_gateway.yaml -f ./05_http-route.yaml

kubectl get svc

kubectl get gateway

GATEWAY=$(kubectl get gateway cilium-gw -o jsonpath='{.status.addresses[0].value}')
echo $GATEWAY

curl --fail -s http://$GATEWAY/echo
