# On a second terminal window
IPv6=$(kubectl get pod pod-worker2 -o jsonpath='{.status.podIPs[1].ip}')
kubectl exec -it pod-worker -- ping -c 5 $IPv6

# On main terminal window
hubble observe --port-forward \
  --ipv6 --from-pod pod-worker

# Disable ip to fqnd
hubble observe --port-forward \
  --ipv6 --from-pod pod-worker \
  -o dict \
  --ip-translation=false \
  --protocol ICMPv6

# On second terminal window
ServiceIPv6=$(kubectl get svc echoserver -o jsonpath='{.spec.clusterIP}')
echo $ServiceIPv6
kubectl exec -i -t pod-worker -- curl -6 http://[$ServiceIPv6]/ | jq

# On main terminal window
hubble observe --port-forward \
  --ipv6 --from-pod pod-worker -o dict --ip-translation=false

# Filter to just see ping messages
hubble observe --port-forward \
  --ipv6 --from-pod pod-worker -o dict \
  --ip-translation=false --protocol ICMPv6
