kubectl apply -f 01_deathstar.yaml

kubectl rollout status deployment deathstar

kubectl get svc deathstar --show-labels

SVC_IP=172.16.0.100
kubectl patch service deathstar -p '{"spec":{"externalIPs":["'$SVC_IP'"]}}'

kubectl get svc deathstar
