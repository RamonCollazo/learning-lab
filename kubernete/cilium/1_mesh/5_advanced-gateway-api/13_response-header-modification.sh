kubectl apply -f ./12_response-header-modifier-http-route.yaml

GATEWAY=$(kubectl get gateway cilium-gw -o jsonpath='{.status.addresses[0].value}')
echo $GATEWAY

curl --fail -s http://$GATEWAY/multiple

curl -v --fail -s http://$GATEWAY/multiple
