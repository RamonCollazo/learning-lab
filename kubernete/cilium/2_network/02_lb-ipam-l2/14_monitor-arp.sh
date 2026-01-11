docker exec -ti clab-garp-demo-neighbor arping 172.16.0.100

# On second terminal window

kubectl -n kube-system get leases cilium-l2announce-default-deathstar -o yaml | yq .spec

# Retrieve MAC
docker exec -ti clab-garp-demo-neighbor arp 172.16.0.100

# veth pari number
docker exec kind-worker2 ip a | grep -B1 aa:c1:ab:c0:33:b0

# Inteface name

ip a | grep if17

# Simulate

docker kill kind-worker2

ip link set net3 down

# Check lease

kubectl -n kube-system get leases cilium-l2announce-default-deathstar -o yaml | yq .spec.holderIdentity

# Check fallback

# On main temrinal window, ARP shows different MAC

# Second termina window
docker exec -ti clab-garp-demo-neighbor curl 12.0.0.100/v1/

# Works fine
