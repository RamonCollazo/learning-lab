kubectl apply -f ./08_cilium-bgp-peer-config.yaml

# On cilium pod

tcpdump -n -i any tcp port 179 and src 172.0.0.2 -w traffic-multihop.pcap
# Quit after 5 sec

TERM=xterm-256color termshark -r traffic-multihop.pcap
# TTL package must show a "10"
