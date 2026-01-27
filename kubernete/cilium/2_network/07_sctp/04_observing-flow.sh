# Observe with hubble
hubble observe --protocol sctp --follow

# On second terminal window, use ncat
PORT=$(kubectl get svc/sctp-deployment -o jsonpath='{.spec.ports[0].nodePort}')
NODE_IP=$(kubectl get nodes -o jsonpath='{.items[?(@.metadata.name=="kind-worker")].status.addresses[?(@.type=="InternalIP")].address}')
ncat --sctp $NODE_IP $PORT
# Back on main terminal window, observe the flow
