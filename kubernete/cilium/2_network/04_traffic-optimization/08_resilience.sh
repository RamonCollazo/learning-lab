kubectl -n landspeeder delete pod luke

kubectl -n spaceport exec $TROOPER2 -- \
  curl -si droids.landspeeder.svc.cluster.local
# Traffic now goes to Obi-Wan
