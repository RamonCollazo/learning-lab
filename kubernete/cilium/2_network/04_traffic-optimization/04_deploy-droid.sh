kubectl -n landspeeder apply -f 03_droids.yaml -o yaml

# Find stormtrooper pod
TROOPER1=$(kubectl -n spaceport get po -l role=soldier --field-selector spec.nodeName=kind-worker -o name)
echo $TROOPER1
TROOPER2=$(kubectl -n spaceport get po -l role=soldier --field-selector spec.nodeName=kind-worker2 -o name)
echo $TROOPER2

# Service test
kubectl -n spaceport exec $TROOPER1 -- \
  curl -si droids.landspeeder.svc.cluster.local

kubectl -n spaceport exec $TROOPER2 -- \
  curl -si droids.landspeeder.svc.cluster.local

# Will fail with obi-wan and luke pods
