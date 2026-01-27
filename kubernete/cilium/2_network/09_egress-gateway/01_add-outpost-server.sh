# Deploy app
docker run -d \
  --name remote-outpost \
  --network kind \
  -e ALLOWED_IP=172.18.0.42,172.18.0.43 \
  quay.io/isovalent-dev/egressgw-whatismyip:latest

# Retrieve IP
OUTPOST=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' remote-outpost)
echo $OUTPOST

# Test
curl http://$OUTPOST:8000
# Should fail because is wrong IP
