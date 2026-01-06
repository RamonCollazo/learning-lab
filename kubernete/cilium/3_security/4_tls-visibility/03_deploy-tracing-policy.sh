# Deploy parser

kubectl apply -f 02_tls-parser.yaml

# Restart tracing
kubectl exec -it -n tetragon pod/tetragon-#### -c tetragon -- \
  tetra getevents -o compact --pod test-pod
