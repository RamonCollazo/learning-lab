kubectl exec -i -t pod-worker -- nslookup -q=AAAA echoserver.default

# Verify connectivity
kubectl exec -i -t pod-worker -- curl -6 'http://echoserver.default.svc' | jq
