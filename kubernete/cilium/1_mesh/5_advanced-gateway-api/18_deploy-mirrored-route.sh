kubectl apply -f ./17_http-mirror-route.yaml

curl -s http://$GATEWAY/mirror | jq
