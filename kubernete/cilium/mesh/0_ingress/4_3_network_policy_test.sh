#!/bin/bash

# On pane1
kubectl apply -f 4_2_network_policy_app.yaml
kubectl rollout status -f 4_2_network_policy_app.yaml

# App test
kubectl exec -it deployment/client -- curl -s http://172.18.255.201/details/1

# Ingress access test from host
curl -so /dev/null -w "%{http_code}\n" http://172.18.255.201/details/1
