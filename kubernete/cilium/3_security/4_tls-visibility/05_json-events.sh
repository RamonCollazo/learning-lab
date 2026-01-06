# On main terminal window:

kubectl exec -n tetragon pod/tetragon-rxqrg -c tetragon -- \
  tetra getevents -o json --pod test-pod | jq -c

# On second terminal window:

kubectl exec --stdin --tty test-pod -- bash

curl --silent --output /dev/null --show-error --max-time 5 --fail https://www.google.com

# Switch back to main terminal window to see logs
