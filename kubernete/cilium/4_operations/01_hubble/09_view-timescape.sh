# Ring buffer exceeded
hubble observe -n tenant-jobs --verdict DROPPED

kubectl -n hubble-timescape port-forward svc/hubble-timescape \
  --address 127.0.0.1 4245:80 &

hubble observe --server localhost:4245 \
  --verdict DROPPED -n tenant-jobs

# Try other filtering methods like `--since 25m` without `--server`
