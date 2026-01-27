# List flow again
hubble observe --namespace tenant-jobs --protocol http

# Filter on http
hubble observe --namespace tenant-jobs --http-path /applicants
hubble observe --namespace tenant-jobs --http-method POST

# Combine filters
hubble observe --namespace tenant-jobs \
  --from-label 'app=coreapi' --protocol http \
  --http-path /applicants --http-method PUT
