#!/bin/bash

# Send traffics to local unless no pods is found
kubectl annotate service servicename service.cilium.io/affinity=local

# Send traffics to remote unless no pods is found
kubectl annotate service servicename service.cilium.io/affinity=remote

# Remove affinity from before
kubectl annotate service servicename service.cilium.io/affinity-
