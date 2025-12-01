kubectl apply -f ./21_redirect-route.yaml

GATEWAY=$(kubectl get gateway cilium-gw -o jsonpath='{.status.addresses[0].value}')
echo $GATEWAY

# Http path redirect
yq '.spec.rules[0]' redirect-route.yaml

curl -l -v http://$GATEWAY/original-prefix

# Redirect to new hostname and new prefix
yq '.spec.rules[1]' redirect-route.yaml

curl -l -v http://$GATEWAY/path-and-host

# Redirect - new status code and new prefix
yq '.spec.rules[2]' redirect-route.yaml

curl -l -v http://$GATEWAY/path-and-status

# Redirect - from http to https
yq '.spec.rules[3]' redirect-route.yaml

curl -l -v http://$GATEWAY/scheme-and-host
