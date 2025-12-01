# Install wireshark, not recommended for production

CILIUM_POD=$(kubectl -n kube-system get po -l k8s-app=cilium -o name)
echo $CILIUM_POD

kubectl -n kube-system exec -ti $CILIUM_POD -- bash

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y install tcpdump termshark

tcpdump -n -i any tcp port 179 and src 172.0.0.2 -w default-timers.pcap
