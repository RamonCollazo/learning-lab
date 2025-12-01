#!/bin/bash

wget https://github.com/kubernetes-sigs/ingress2gateway/releases/download/v0.4.0/ingress2gateway_Linux_x86_64.tar.gz
tar -xvzf ingress2gateway_Linux_x86_64.tar.gz
./ingress2gateway help

# Check for cilium provider
./ingress2gateway print --providers=cilium

./ingress2gateway print --providers=cilium > ingress2gateway.yaml


# CRD install
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.2.0/config/crd/standard/gateway.networking.k8s.io_gatewayclasses.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.2.0/config/crd/standard/gateway.networking.k8s.io_gateways.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.2.0/config/crd/standard/gateway.networking.k8s.io_httproutes.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.2.0/config/crd/standard/gateway.networking.k8s.io_referencegrants.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.2.0/config/crd/standard/gateway.networking.k8s.io_grpcroutes.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.2.0/config/crd/experimental/gateway.networking.k8s.io_tlsroutes.yaml

# Upgrade and enable gatewayapi
cilium upgrade \
  --version 1.18.2 \
  --reuse-values \
  --set gatewayAPI.enabled=true
cilium status --wait


cilium config view | grep enable-gateway-api

# REstart operator
kubectl -n kube-system rollout restart deployment cilium-operator


# Deploy config
kubectl apply -f ingress2gateway.yaml
kubectl get svc cilium-gateway-cilium
kubectl get gateway cilium

GATEWAY=$(kubectl get gateway cilium -o jsonpath='{.status.addresses[0].value}')
echo $GATEWAY

# Replace host IP addr
vi /etc/hosts

# Verify
curl -s https://bookinfo.cilium.rocks/details/1 | jq
grpcurl -proto ./demo.proto hipstershop.cilium.rocks:443 hipstershop.ProductCatalogService/ListProducts | jq

# Remove ingress
kubectl delete ingress --all

# Check gateway api
grpcurl -proto ./demo.proto hipstershop.cilium.rocks:443 hipstershop.ProductCatalogService/ListProducts | jq
