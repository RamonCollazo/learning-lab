#!/bin/bash

# For https, TLS certificate is needed, example with mkcert
mkcert '*.cilium.rocks'

kubectl create secret tls demo-cert \
  --key=_wildcard.cilium.rocks-key.pem \
  --cert=_wildcard.cilium.rocks.pem
