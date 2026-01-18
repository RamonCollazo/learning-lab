kubectl -n landspeeder apply -f droids.yaml

kubectl -n spaceport exec $TROOPER1 -- \
  curl -si droids.landspeeder.svc.cluster.local
# Responce should come from Obi-Wan

kubectl -n spaceport exec $TROOPER2 -- \
  curl -si droids.landspeeder.svc.cluster.local
# Responce should come from Luke
