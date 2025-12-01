#!/bin/bash

kubectl apply -f default-deny.yaml

# Wanted connection should still work 
curl --fail -v http://172.18.255.201/details/1
kubectl exec -it deployment/client -- curl --fail -v http://172.18.255.201/details/1
