docker exec -it clab-bgp-cplane-devel-tor vtysh -c 'show bgp ipv4 neighbor' |
  grep -A 10 "Graceful restart information"

docker exec -it clab-bgp-cplane-devel-tor vtysh -c 'show bgp ipv4 neighbor' |
  grep -A 10 "Graceful restart information"

kubectl -n kube-system rollout restart daemonset cilium

docker exec -it clab-bgp-cplane-devel-tor vtysh -c 'show bgp ipv4 '
echo "========================="
docker exec -it clab-bgp-cplane-devel-tor ip r
