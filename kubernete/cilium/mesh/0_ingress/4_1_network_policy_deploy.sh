#!/bin/bash

kubectl apply -f 4_0_network_policy.yaml
# In a different pane
hubble observe -f --identity ingress
# In the original pane
curl --fail -v http://172.18.255.201/details/1
# Watch output on the second pane
