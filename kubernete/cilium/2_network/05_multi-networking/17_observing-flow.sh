# Hubble CLI
hubble observe --pod client --protocol icmp

# Filter
hubble observe --pod client --protocol icmp --last 50 --verdict=DROPPED

# Extract identity of endpoints
CLIENT_ID=$(kubectl get cep client -o jsonpath='{.status.identity.id}')
CLIENT_CIL1_ID=$(kubectl get cep client-cil1 -o jsonpath='{.status.identity.id}')
echo $CLIENT_ID
echo $CLIENT_CIL1_ID

# Observe ICMP from client dropped by network policy
hubble observe --protocol icmpv4 --last 50 --verdict=DROPPED --identity $CLIENT_ID

# Observe TCP
hubble observe --protocol tcp --last 50 --identity $CLIENT_CIL1_ID
