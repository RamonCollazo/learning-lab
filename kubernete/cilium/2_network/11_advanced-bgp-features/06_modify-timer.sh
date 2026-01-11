kubectl apply -f ./05_cilium-bgp-peer-config.yaml

# On cilium pod
tcpdump -n -i any tcp port 179 and src 172.0.0.2 -w fast-timers.pcap
# Quit after 10 seconds
TERM=xterm-256color termshark -r fast-timers.pcap
