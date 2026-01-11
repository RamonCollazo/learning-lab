kubectl apply -f ./11_cilium-bgp-peer-config.yaml

docker exec -it clab-bgp-cplane-devel-tor vtysh -c 'show bgp ipv4 neighbor' | grep "Graceful Restart Capability" -A 8

kubectl -n kube-system rollout restart daemonset cilium

# On another terminal window
docker exec -it clab-bgp-cplane-devel-tor vtysh -c 'show bgp ipv4 '
echo "========================="
docker exec -it clab-bgp-cplane-devel-tor ip r
echo "========================="
docker exec -it clab-bgp-cplane-devel-tor vtysh -c 'show bgp ipv4 neighbor' | grep "Graceful restart information" -A 10
