kubectl -n landspeeder get svc droids

CILIUM1=$(kubectl -n kube-system get po -l k8s-app=cilium --field-selector spec.nodeName=kind-worker -o name)
echo $CILIUM1

kubectl exec -it -n kube-system $CILIUM1 -c cilium-agent -- \
  cilium-dbg service list |
  grep -E '^ID|10.96.89.211:80' |
  GREP_COLORS='mt=01;31' grep --color=always -B1 '10.96.89.211:80' |
  GREP_COLORS='mt=01;32:sl=01;33' grep --color=always -B1 -E 'LocalRedirect|ClusterIP'
# Behaves as standard ClusterIP
