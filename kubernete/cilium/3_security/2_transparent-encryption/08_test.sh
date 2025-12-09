# On main terminal

kubectl apply -f 06_nginx-deployment.yaml

kubectl apply -f 07_client.yaml

kubectl rollout status deployment/nginx-deployment

NGINX3=$(kubectl get pods -l app=nginx --field-selector spec.nodeName=kind-worker3 -o jsonpath='{.items[0].status.podIP}')
echo $NGINX3

kubectl exec -ti client -- curl -o /dev/null -s -w "%{http_code}\n" http://$NGINX3
