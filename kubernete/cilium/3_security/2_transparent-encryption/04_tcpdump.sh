# On another terminal

CILIUM_POD=$(kubectl -n kube-system get po -l k8s-app=cilium --field-selector spec.nodeName=kind-worker -o name)
echo $CILIUM_POD

kubectl -n kube-system exec -ti $CILIUM_POD -- bash

apt-get update
apt-get -y install tcpdump

tcpdump -n -i cilium_wg0
