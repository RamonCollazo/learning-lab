kubectl apply -f ./07_echo-header-http-route.yaml

GATEWAY=$(kubectl get gateway cilium-gw -o jsonpath='{.status.addresses[0].value}')
echo $GATEWAY

curl --fail -s http://$GATEWAY/cilium-add-a-request-header
