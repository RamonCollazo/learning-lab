kubectl apply -f service-red.yaml
kubectl apply -f service-green.yaml
kubectl get svc -n tenant-b --show-labels
