# Access outpost from xwing
for i in $(seq 1 10); do
  kubectl exec -ti xwing -- \
    curl --max-time 2 http://172.18.0.7:8000
done
