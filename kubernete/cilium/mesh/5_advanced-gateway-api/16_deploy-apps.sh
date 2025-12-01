kubectl apply -f ./14_demo-app.yaml
kubectl get -f ./14_demo-app.yaml

kubectl apply -f ./15_http-mirror-route.yaml

GATEWAY=$(kubectl get gateway cilium-gw -o jsonpath='{.status.addresses[0].value}')
echo $GATEWAY

curl -s http://$GATEWAY/mirror | jq
