kubectl expose deployment deathstar --name deathstar-3 --port 80 --type LoadBalancer

kubectl get svc deathstar-3 --show-labels

# Doesn't have externalIP

kubectl label svc deathstar-3 color=blue

kubectl get svc deathstar-3 --show-labels

# Will have externalIP

SVC2_IP=$(kubectl get svc deathstar-3 -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo $SVC2_IP
docker exec -ti clab-garp-demo-neighbor curl --connect-timeout 1 $SVC2_IP/v1/
