# In all clusters
kubectl annotate service servicename service.cilium.io/global="true"

# Won't allow requests outside of cluster
kubectl annotate service servicename service.cilium.io/shared="false"
