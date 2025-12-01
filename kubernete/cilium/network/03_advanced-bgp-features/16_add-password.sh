docker exec -it clab-bgp-cplane-devel-tor vtysh

conf t
router bgp 65000
neighbor 172.0.0.2 password my-secret-password
exit
exit

show bgp ipv4 summary
