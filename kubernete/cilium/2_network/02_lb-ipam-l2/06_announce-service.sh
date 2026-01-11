# On second terminal window:

kubectl label svc deathstar color=blue --overwrite

# On main terminal window:

curl --connect-timeout 1 http://$SVC_IP/v1/
