# On a second terminal window:

kubectl apply -f 04_l2policy.yaml

curl --connect-timeout 1 http://$SVC_IP/v1/

# Because of policy, it only applies on services labeled `color=blue`
