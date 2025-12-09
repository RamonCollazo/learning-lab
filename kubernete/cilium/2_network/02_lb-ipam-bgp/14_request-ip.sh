kubectl apply -f service-yellow.yaml
kubectl apply -f pool-yellow.yaml

kubectl get svc/service-yellow -n tenant-c
