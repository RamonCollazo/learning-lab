# Only show dest. IP
hubble observe -n tenant-jobs --from-label=app=crawler

# Tell Cilium to inspect port 53
hubble observe --namespace tenant-jobs --protocol dns

kubectl -n tenant-jobs apply -f https://docs.isovalent.com/public/dns-visibility.yaml

# Get egrees policy
kubectl get cnp dns-visibility -n tenant-jobs -o yaml | yq .spec
