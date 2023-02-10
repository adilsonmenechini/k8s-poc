# Helm

## Command

```
# Create templates
helm create helm-templates

# Install + dry-run
helm install  helm-templates . -f ./values.yaml  -n ns-poc --dry-run

# Upgrade
helm upgrade --install  helm-templates . -f ./values.yaml -n ns-poc

# History
helm history helm-templates

# Rollback
helm rollback helm-templates 1
 
# Delete
helm delete helm-templates -n ns-poc
```

## Overview

```
❯ kubectl get pod,deploy,service,ep,hpa -n ns-poc
NAME                            READY   STATUS    RESTARTS   AGE
pod/helm-templates-786f87bf9b-kwjzk   1/1     Running   0          118s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/helm-templates   1/1     1            1           4m26s

NAME               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
service/helm-templates   ClusterIP   10.103.99.205   <none>        80/TCP    4m26s

NAME                 ENDPOINTS      AGE
endpoints/helm-templates   10.1.0.23:80   4m26s

NAME                                           REFERENCE             TARGETS                        MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/helm-templates   Deployment/helm-templates   <unknown>/80%, <unknown>/80%   1         4         1          4m26s
```

