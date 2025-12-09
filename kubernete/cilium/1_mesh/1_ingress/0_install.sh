#!/bin/bash

# Cilium must be installed with " --set ingressController.enabled=true "

cilium config view | grep ingress-controller
# Output should look like:
# enable-ingress-controller                         true
