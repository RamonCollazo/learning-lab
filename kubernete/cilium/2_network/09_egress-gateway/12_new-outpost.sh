docker run -d \
  --name remote-outpost-2 \
  --network kind \
  -e ALLOWED_IP=172.18.0.84,172.18.0.85 \
  quay.io/isovalent-dev/egressgw-whatismyip:latest

# Get IP from new outpost
OUTPOST2=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' remote-outpost-2)
echo $OUTPOST2

# Make request
for i in $(seq 1 10); do
  kubectl exec -ti xwing -- \
    curl --max-time 2 http://$OUTPOST2:8000
done
# Should be rejected
