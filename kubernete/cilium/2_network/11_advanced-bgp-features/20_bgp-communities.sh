kubectl apply -f ./19_cilium-bgp-advertisement.yaml

docker exec -it clab-bgp-cplane-devel-tor vtysh -c 'show bgp ipv4 10.244.0.0/24'
