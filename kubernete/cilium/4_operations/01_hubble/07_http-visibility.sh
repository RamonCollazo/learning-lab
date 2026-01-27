# Verify if hubble is collecting http details
hubble observe --namespace tenant-jobs --protocol http

kubectl -n tenant-jobs apply -f https://docs.isovalent.com/public/http-ingress-visibility.yaml

# Observe policy
kubectl get cnp http-ingress-visibility -n tenant-jobs -o yaml | yq .spec
