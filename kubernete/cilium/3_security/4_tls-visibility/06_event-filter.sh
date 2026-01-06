# Stop logs `Ctrl+C` on main terminal window
# Filter using jq

kubectl exec -n tetragon pod/tetragon-rxqrg -c tetragon -- \
  tetra getevents -o json --pod test-pod | jq -r '.tls.negotiated_version | select ( . != null)'

# Second terminal window:

curl -s -o /dev/null https://www.google.com

# What TLS 1.3 appear on main temrinal window
