kubectl apply -f 37_load-balancing-http-route.yaml

kubectl -n gamma exec -it client -- bash -c '
for _ in {1..500}; do
  curl -s -k "http://echo/load-balancing" >> curlresponses9010.txt;
done
grep -o "Hostname=echo-v1" curlresponses9010.txt | sort | uniq -c
grep -o "Hostname=echo-v2" curlresponses9010.txt | sort | uniq -c
'
