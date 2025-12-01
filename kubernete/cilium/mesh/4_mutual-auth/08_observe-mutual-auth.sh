kubectl exec tiefighter -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
kubectl exec xwing -- curl -s --connect-timeout 1 -XPOST deathstar.default.svc.cluster.local/v1/request-landing

hubble observe --type drop --from-pod default/xwing

hubble observe --type drop --from-pod default/tiefighter

hubble observe --type policy-verdict --from-pod default/tiefighter
