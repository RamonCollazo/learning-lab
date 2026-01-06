# Visualize events

kubectl exec -it -n tetragon daemonsets/tetragon -c tetragon -- \
  tetra getevents -o compact

# On a second terminal window:

kubectl run -i --tty test-pod \
  --image=quay.io/isovalent-dev/ktls-curl:latest \
  --restart=Never --rm

# On main terminal, to filter pods:

TEST_NODE=$(kubectl get pod test-pod -o jsonpath='{.spec.nodeName}')
echo $TEST_NODE

TEST_TETRAGON=$(kubectl -n tetragon get pods -l app.kubernetes.io/name=tetragon --field-selector spec.nodeName=$TEST_NODE -o name)

kubectl exec -it -n tetragon $TEST_TETRAGON -c tetragon -- \
  tetra getevents -o compact --pod test-pod

# On second terminal window:

curl --silent --output /dev/null --show-error --fail https://www.google.com

# Observe the events on main terminal window
