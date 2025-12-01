KUBECTL_EXTERNAL_DIFF='colordiff -u' \
  kubectl diff -f 05_mutual-auth.yaml |
  grep -A30 ' spec:'

kubectl apply -f 05_mutual-auth.yaml
