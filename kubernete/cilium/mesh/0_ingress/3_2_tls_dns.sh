#!/bin/bash

# Verify ingress
kubectl get ingress tls-ingress
# Retrieve IP
INGRESS_IP=$(kubectl get ingress tls-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo $INGRESS_IP
# Add DNS entry
cat << EOF >> /etc/hosts
${INGRESS_IP} bookinfo.cilium.rocks
${INGRESS_IP} hipstershop.cilium.rocks
EOF
