# Check host identity

kubectl get pods -n kube-system -l k8s-app=cilium

# List endpoints

# Need to choose one pod
kubectl exec -it -n kube-system cilium-#### -- cilium endpoint list

# Line with `reserved:host` and identity `1` is local host
