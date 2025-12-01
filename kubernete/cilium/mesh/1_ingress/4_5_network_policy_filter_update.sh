#!/bin/bash

kubectl apply -f ./4_4_network_policy_filter.yaml

curl -so /dev/null -w "%{http_code}\n" http://172.18.255.201/details/1
