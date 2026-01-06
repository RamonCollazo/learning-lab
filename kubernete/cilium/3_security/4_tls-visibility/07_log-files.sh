# Cancel current logs on main terminal window `Ctrl+C`
# View last events

kubectl exec -n tetragon pod/tetragon-rxqrg -c tetragon -- \
  tail /var/run/cilium/hubble/tetragon.log | jq -c

# Wild card to see all events

kubectl exec -n tetragon pod/tetragon-rxqrg -c tetragon -- \
  sh -c 'cat /var/run/cilium/hubble/tetragon*.log' | jq -c
