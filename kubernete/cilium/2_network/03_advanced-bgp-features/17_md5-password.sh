CILIUM_POD=$(kubectl -n kube-system get po -l k8s-app=cilium -o name)
echo $CILIUM_POD

kubectl -n kube-system exec -ti $CILIUM_POD -- bash

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y install tcpdump termshark

tcpdump -n -i any tcp port 179 and src 172.0.0.2 -w md5.pcap
# Stop after 5 sec

TERM=xterm-256color termshark -r md5.pcap
# On termshark, Transmission Control Protocol, Options, should show TCP MD5 signature
