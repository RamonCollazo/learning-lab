kubectl apply -f ./09_echo-header-http-route.yaml

curl --fail -s http://$GATEWAY/cilium-add-a-request-header
