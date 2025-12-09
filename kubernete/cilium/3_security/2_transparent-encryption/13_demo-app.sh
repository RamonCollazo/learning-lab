kubectl apply -f 12_endor.yaml
kubectl get -f 12_endor.yaml

#IPSec

kubectl -n kube-system exec -ti ds/cilium -- bash

apt-get update
apt-get -y install tcpdump

tcpdump -n -i cilium_vxlan esp

# Key Rotation

exit

read KEYID ALGO PSK KEYSIZE < <(kubectl get secret -n kube-system cilium-ipsec-keys -o go-template='{{.data.keys | base64decode}}{{printf "\n"}}')
# Remove the '+' character from KEYID, then print it
KEYID=${KEYID%\+}
echo $KEYID
echo $PSK

NEW_PSK=($(dd if=/dev/urandom count=20 bs=1 2> /dev/null | xxd -p -c 64))
echo $NEW_PSK
patch='{"stringData":{"keys":"'$((KEYID+1))'+ rfc4106(gcm(aes)) '$NEW_PSK' 128"}}'
kubectl patch secret -n kube-system cilium-ipsec-keys -p="${patch}"

read NEWKEYID ALGO NEWPSK KEYSIZE < <(kubectl get secret -n kube-system cilium-ipsec-keys -o go-template='{{.data.keys | base64decode}}{{printf "\n"}}')
NEWKEYID=${NEWKEYID%\+}
echo $NEWKEYID
echo $NEWPSK
