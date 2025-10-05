#!/bin/bash
cilium install \
  --set cluster.name=cluster1 \
  --set cluster.id=1 \
  --set ipam.mode=kubernetes
cilium install \
  --set cluster.name=cluster2 \
  --set cluster.id=2 \
  --set ipam.mode=kubernetes
cilium hubble enable --ui
cilium status --wait
