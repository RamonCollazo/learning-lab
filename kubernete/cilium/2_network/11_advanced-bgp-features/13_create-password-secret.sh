kubectl -n kube-system create secret generic \
  --type=string secretname \
  --from-literal=password=my-secret-password
