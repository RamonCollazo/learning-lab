kubectl create ns tenant-a
kubectl create ns tenant-b
kubectl create ns tenant-c
kubectl create -f https://docs.isovalent.com/public/tenant-services.yaml -n tenant-a
kubectl create -f https://docs.isovalent.com/public/tenant-services.yaml -n tenant-b
kubectl create -f https://docs.isovalent.com/public/tenant-services.yaml -n tenant-c

cilium status --wait

hubble status

hubble list nodes

kubectl get pods --all-namespaces | grep "tenant"
