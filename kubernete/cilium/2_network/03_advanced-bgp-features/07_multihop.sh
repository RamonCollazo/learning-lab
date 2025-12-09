CILIUM_POD=$(kubectl -n kube-system get po -l k8s-app=cilium -o name)
echo $CILIUM_POD

kubectl -n kube-system exec -ti $CILIUM_POD -- bash

tcpdump -n -i any tcp port 179 and src 172.0.0.2 -w traffic-no-multihop.pcap

# Quit after 5 sec
TERM=xterm-256color termshark -r traffic-no-multihop.pcap

# In termshark, is shown that TTL for bgp is "1"
