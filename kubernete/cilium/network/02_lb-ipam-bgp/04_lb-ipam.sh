kubectl apply -f 03_service-blue.yaml
kubectl get svc/service-blue -n tenant-a
kubectl apply -f 02_pool.yaml
kubectl get svc/service-blue -n tenant-a
