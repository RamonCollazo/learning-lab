# Enforce

kubectl apply -f 08_tenant-a-extra-policy.yaml

# Test policy

kubectl exec -n tenant-a frontend-service -- \
  curl -sI --max-time 5 backend-service.tenant-a

kubectl exec -n tenant-a frontend-service -- \
  curl -sI --max-time 5 api.twitter.com

kubectl exec -n tenant-a frontend-service -- \
  curl -sI --max-time 5 backend-service.tenant-b

# Test deny

kubectl exec -n tenant-a frontend-service -- \
  curl -sI --max-time 5 www.google.com

kubectl exec -n tenant-a frontend-service -- \
  curl -sI --max-time 5 backend-service.tenant-c

hubble observe --namespace tenant-a
