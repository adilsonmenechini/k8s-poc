# Helm

## Command

```
# Create templates
helm create poc-helm

# Install + dry-run
helm install  poc-helm . -f ./values.yaml  --dry-run

# Upgrade
helm upgrade --install  poc-helm . -f ./values.yaml 

# History
helm history poc-helm

# Rollback
helm rollback poc-helm 1
 
# Delete
helm delete poc-helm 
```

