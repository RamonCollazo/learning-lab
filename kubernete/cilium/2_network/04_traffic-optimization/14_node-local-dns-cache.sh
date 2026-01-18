# Deploy NodeLocal Daemonset
kubectl apply -f 12_node-local-dns.yaml

# Deploy policy
kubectl apply -f 13_node-local-dns-lrp.yaml

# Get IPs and DNS
DNS_LOCAL=$(kubectl -n kube-system get po -l k8s-app=node-local-dns --field-selector spec.nodeName=kind-worker -o jsonpath='{.items[].status.podIP}')
echo $DNS_LOCAL

DNS_NON_LOCAL=$(kubectl -n kube-system get po -l k8s-app=node-local-dns --field-selector spec.nodeName=kind-worker2 -o jsonpath='{.items[].status.podIP}')
echo $DNS_NON_LOCAL

# Check metrics
echo "## Stats on Local DNS Cache ##"
kubectl -n landspeeder exec obi-wan -- curl $DNS_LOCAL:9253/metrics | grep coredns_dns_request_count_total
echo "## Stats on Non-Local DNS Cache ##"
kubectl -n landspeeder exec obi-wan -- curl $DNS_NON_LOCAL:9253/metrics | grep coredns_dns_request_count_total

# Run DNS requests
kubectl -n landspeeder exec obi-wan -- getent hosts swapi.dev
kubectl -n landspeeder exec obi-wan -- getent hosts isovalent.com
kubectl -n landspeeder exec obi-wan -- getent hosts cilium.io

# Verify local ones only increase
echo "## Stats on Local DNS Cache ##"
kubectl -n landspeeder exec obi-wan -- curl $DNS_LOCAL:9253/metrics | grep coredns_dns_request_count_total
echo "## Stats on Non-Local DNS Cache ##"
kubectl -n landspeeder exec obi-wan -- curl $DNS_NON_LOCAL:9253/metrics | grep coredns_dns_request_count_total
