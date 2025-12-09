# Apply

kubectl apply -f 03_tenant-a-default-policy.yaml

# Test forwarded

kubectl exec -n tenant-a frontend-service -- \
  curl -sI backend-service.tenant-a

hubble observe --from-pod tenant-a/frontend-service

# Test denied

kubectl exec -n tenant-a frontend-service -- \
  curl -sI --max-time 5 api.x.com

kubectl exec -n tenant-a frontend-service -- \
  curl -sI --max-time 5 backend-service.tenant-b
