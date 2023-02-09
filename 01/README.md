# 01 Exemplo

## Pod
```
❯ kubectl run --image nginx poc-nginx -l app=poc-nginx --port=80 --dry-run=client  -oyaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    app: poc-nginx
  name: poc-nginx
spec:
  containers:
  - image: nginx
    name: poc-nginx
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

```


## Deployment
```
❯ kubectl create deployment --image nginx poc-nginx  --port=80 --dry-run=client  -oyaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: poc-nginx
  name: poc-nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: poc-nginx
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: poc-nginx
    spec:
      containers:
      - image: nginx
        name: nginx
        ports:
        - containerPort: 80
        resources: {}
status: {}
```


## Service
```
❯ kubectl create service clusterip poc-nginx  --tcp=8080:80 --dry-run=client -oyaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: poc-nginx
  name: poc-nginx
spec:
  ports:
  - name: 8080-80
    port: 8080
    protocol: TCP
    targetPort: 80
  selector:
    app: poc-nginx
  type: ClusterIP
status:
  loadBalancer: {}
```


## Namespace
```
❯ kubectl create namespace ns-poc --dry-run=client -oyaml
apiVersion: v1
kind: Namespace
metadata:
  creationTimestamp: null
  name: ns-poc
spec: {}
status: {}

```

## Overview

```
❯ kubectl apply -f namespace.yaml
namespace/ns-poc created
❯ kubectl apply -f deployment.yaml -n ns-poc
deployment.apps/poc-nginx created
❯ kubectl apply -f service.yaml -n ns-poc
service/poc-nginx created
❯ kubectl get pod,deploy,service,ep -n ns-poc
NAME                             READY   STATUS    RESTARTS   AGE
pod/poc-nginx-7448cf46cc-4gsdb   1/1     Running   0          16s

NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/poc-nginx   1/1     1            1           16s

NAME                TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/poc-nginx   ClusterIP   10.105.248.147   <none>        8080/TCP   9s

NAME                  ENDPOINTS      AGE
endpoints/poc-nginx   10.1.0.16:80   9s
```

## HPA

```
❯ kubectl autoscale deployment poc-nginx  --min=1 --max=4 -n ns-poc --dry-run=client -oyaml
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  creationTimestamp: null
  name: poc-nginx
spec:
  maxReplicas: 4
  minReplicas: 1
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: poc-nginx
status:
  currentReplicas: 0
  desiredReplicas: 0
```