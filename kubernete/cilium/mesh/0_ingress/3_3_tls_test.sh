#!/bin/bash

# Make cert be trusted
mkcert -install
# Curl test
curl -s https://bookinfo.cilium.rocks/details/1 | jq
# gRPC test
grpcurl -proto ./demo.proto hipstershop.cilium.rocks:443 hipstershop.ProductCatalogService/ListProducts | jq
