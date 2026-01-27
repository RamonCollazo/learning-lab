helm upgrade jobs-app ./helm/jobs-app.tgz \
  --install \
  --namespace tenant-jobs --create-namespace \
  --values ./helm/jobs-app-values.yaml
