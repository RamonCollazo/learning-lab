kubectl get nodes -l kubernetes.io/hostname=clab-bgp-cplane-devel-control-plane

kubectl apply -f ./02_config.yaml

cilium bgp peers

docker exec -it clab-bgp-cplane-devel-tor vtysh -c 'show bgp ipv4'
