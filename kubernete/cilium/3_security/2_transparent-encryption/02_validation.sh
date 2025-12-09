# Validate Setup
kubectl get ciliumnode kind-worker2 \
  -o jsonpath='{.metadata.annotations.network\.cilium\.io/wg-pub-key}'

CILIUM_POD=$(kubectl -n kube-system get po -l k8s-app=cilium --field-selector spec.nodeName=kind-worker2 -o name)
echo $CILIUM_POD

kubectl -n kube-system exec -ti $CILIUM_POD -- bash

cilium status | grep Encryption

# Validate traffic encryption

apt-get update
apt-get -y install tcpdump

tcpdump -n -i cilium_wg0 | grep ICMP

# On another terminal

kubectl apply -f wg_pods.yaml -o yaml

kubectl wait --for=condition=Ready -f 01_wg-pods.yaml

POD2=$(kubectl get pod pod-worker2 --template '{{.status.podIP}}')
echo $POD2

kubectl exec -ti pod-worker -- ping $POD2
