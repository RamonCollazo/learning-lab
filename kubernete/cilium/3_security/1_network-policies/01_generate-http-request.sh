kubectl exec -n tenant-a frontend-service -- \
  curl -sI backend-service.tenant-a

kubectl exec -n tenant-a frontend-service -- \
  curl -sI backend-service.tenant-b

kubectl exec -n tenant-a frontend-service -- \
  curl -sI api.x.com

hubble observe --from-pod tenant-a/frontend-service --protocol tcp
