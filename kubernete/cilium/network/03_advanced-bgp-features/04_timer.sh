cilium bgp peers -o json

# On cilium pod
mkdir -p /root/.config/termshark/
echo -e "[main]\ndark-mode = true" >/root/.config/termshark/termshark.toml

TERM=xterm-256color termshark -r default-timers.pcap
