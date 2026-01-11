# Prepare visualization

kubectl get leases -n kube-system cilium-l2announce-default-deathstar-2 -o yaml

LEASE_NODE=$(kubectl -n kube-system get leases cilium-l2announce-default-deathstar-2 -o jsonpath='{.spec.holderIdentity}')
echo $LEASE_NODE

LEASE_CILIUM_POD=$(kubectl -n kube-system get pod -l k8s-app=cilium --field-selector spec.nodeName=$LEASE_NODE -o name)
echo $LEASE_CILIUM_POD

kubectl -n kube-system exec -ti $LEASE_CILIUM_POD -- bash

apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install tcpdump termshark

tcpdump -i any arp -w arp.pcap

# On a second terminal window:

docker exec -ti clab-garp-demo-neighbor \
  curl --connect-timeout 1 http://12.0.0.101/v1/

# On main terminal window, `Ctrl+C`

mkdir -p /root/.config/termshark/
echo -e "[main]\ndark-mode = true" >/root/.config/termshark/termshark.toml

TERM=xterm-256color termshark -r arp.pcap

# Should see arp request from different IP add
