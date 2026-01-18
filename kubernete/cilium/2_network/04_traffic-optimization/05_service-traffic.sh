# Inspect node labels
kubectl get no --show-labels |
  GREP_COLORS='mt=1;32' grep --color=always -E '[^=]+$' |
  grep --color=always topology.kubernetes.io/zone=

# Check pod affinity
kubectl -n landspeeder get pod r2-d2 -o yaml | yq .spec.affinity
