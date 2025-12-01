#!/bin/bash
# All clusters
cilium clustermesh enable --service-type NodePort # In prod, use LoadBalancer

# Must have acces to all clusters
cilium clustermesh connect \
  --context kind-cluster1 \
  --destination-context kind-cluster2
