#!/bin/bash

# CRD must be installed:
# gatewayclasses.gateway.networking.k8s.io
# gateways.gateway.networking.k8s.io
# httproutes.gateway.networking.k8s.io
# referencegrants.gateway.networking.k8s.io
# tlsroutes.gateway.networking.k8s.io

cilium install --version v1.18.2 \
  --namespace kube-system \
  --set kubeProxyReplacement=true \
  --set gatewayAPI.enabled=true \

cilium status --wait

# See if gateway api was deployed
cilium config view | grep -w "enable-gateway-api"

kubectl get GatewayClass
