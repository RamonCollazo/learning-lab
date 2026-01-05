# On another terminal window:

hubble observe --to-identity 1 --port 22 -f

# On main terminal window:

for node in $(docker ps --format '{{.Names}}'); do
  echo "==== Testing connection to node $node ===="
  IP=$(docker inspect $node -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}')
  nc -vz -w2 $IP 22
done

# View flows in hubble on second terminal window
