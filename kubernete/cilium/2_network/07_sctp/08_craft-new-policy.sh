kubectl apply -f 05_sctp-client-source-deny.yaml -f 06_sctp-client-source.yaml
kubectl get pods --show-labels

# Get pods IP
SCTP_POD_IP=$(kubectl get pods -o wide -l=app=sctp -o=jsonpath='{.items[0].status.podIP}')
echo $SCTP_POD_IP

# Test connectivity
kubectl exec -it sctpclient -- nc $SCTP_POD_IP 9999 --sctp
kubectl exec -it sctpclient-deny -- nc $SCTP_POD_IP 9999 --sctp

# Apply network policy
kubectl apply -f 07_sctp-net-pol.yaml

# Rerun test connectivity
kubectl exec -it sctpclient -- nc $SCTP_POD_IP 9999 --sctp
kubectl exec -it sctpclient-deny -- nc $SCTP_POD_IP 9999 --sctp
# Second test should timeout

# Review packet flow in hubble
hubble observe --protocol sctp --verdict DROPPED
# In Hubble UI, in the default ns, click `Any verdict`. Filter `Dropped` verdict
