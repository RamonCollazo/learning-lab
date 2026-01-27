kubectl apply -f 05_echo-kube-ipv6.yaml

# Both ipv4 and ipv6 should be allocated
kubectl describe svc echoserver

# Extract ipv6
ServiceIPv6=$(kubectl get svc echoserver -o jsonpath='{.spec.clusterIP}')
echo $ServiceIPv6

kubectl exec -i -t pod-worker -- curl -6 http://[$ServiceIPv6]/ | jq
