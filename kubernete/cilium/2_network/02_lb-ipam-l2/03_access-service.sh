docker exec -e SVC_IP=$SVC_IP -ti clab-garp-demo-neighbor bash

curl --connect-timeout 1 http://$SVC_IP/v1/

# If not advertised via ARP, it will timeout
