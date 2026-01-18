kubectl apply -f 10_droids-lrp.yaml -o yaml | yq .spec
# This will redirect droids to local backend with label role=droid

# Verify eBPF
kubectl exec -it -n kube-system $CILIUM1 -c cilium-agent -- \
  cilium-dbg service list |
  grep -E '^ID|10.96.89.211:80' |
  GREP_COLORS='mt=01;31' grep --color=always -B1 '10.96.89.211:80' |
  GREP_COLORS='mt=01;32:sl=01;33' grep --color=always -B1 -E 'LocalRedirect|ClusterIP'
# Service type is now LocalRedirect

# Verify
kubectl -n landspeeder get po -l role=droid --field-selector spec.nodeName=kind-worker -o wide

TROOPER1=$(kubectl -n spaceport get po -l role=soldier --field-selector spec.nodeName=kind-worker -o name)
echo $TROOPER1
TROOPER2=$(kubectl -n spaceport get po -l role=soldier --field-selector spec.nodeName=kind-worker2 -o name)
echo $TROOPER2

kubectl -n spaceport exec $TROOPER1 -- \
  curl -si droids.landspeeder.svc.cluster.local
# Responces now comes from R2-D2 (first node)

kubectl -n spaceport exec $TROOPER2 -- \
  curl -si droids.landspeeder.svc.cluster.local
# Responces now comes from C3-PO (second node)
