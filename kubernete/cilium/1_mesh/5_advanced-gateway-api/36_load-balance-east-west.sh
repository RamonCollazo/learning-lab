kubectl apply -f 35_load-balancing-http-route.yaml

kubectl -n gamma exec -it client -- bash -c '
for _ in {1..500}; do
  curl -s -k "http://echo/load-balancing" >> curlresponses.txt;
done
grep -o "Hostname=echo-v1" curlresponses.txt | sort | uniq -c
grep -o "Hostname=echo-v2" curlresponses.txt | sort | uniq -c
'
