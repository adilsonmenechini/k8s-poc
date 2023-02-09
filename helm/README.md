# Helm

## Command

```
# Create templates
helm create poc-helm

# Install + dry-run
helm install  poc-helm . -f ./values.yaml  -n ns-poc --dry-run

# Upgrade
helm upgrade --install  poc-helm . -f ./values.yaml -n ns-poc

# History
helm history poc-helm

# Rollback
helm rollback poc-helm 1
 
# Delete
helm delete poc-helm -n ns-poc
```

## Overview

```
❯ kubectl get pod,deploy,service,ep,hpa -n ns-poc
NAME                            READY   STATUS    RESTARTS   AGE
pod/poc-helm-786f87bf9b-kwjzk   1/1     Running   0          118s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/poc-helm   1/1     1            1           4m26s

NAME               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
service/poc-helm   ClusterIP   10.103.99.205   <none>        80/TCP    4m26s

NAME                 ENDPOINTS      AGE
endpoints/poc-helm   10.1.0.23:80   4m26s

NAME                                           REFERENCE             TARGETS                        MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/poc-helm   Deployment/poc-helm   <unknown>/80%, <unknown>/80%   1         4         1          4m26s
```

