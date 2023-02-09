#
## Pod
```
❯ kubectl run --image nignx poc-nignx -l app=poc-nignx --port=80 --dry-run=client  -oyaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    app: poc-nignx
  name: poc-nignx
spec:
  containers:
  - image: nignx
    name: poc-nignx
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

```


## Deployment
```
kubectl create deployment --image nignx poc-nignx  --port=80 --dry-run=client  -oyaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: poc-nignx
  name: poc-nignx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: poc-nignx
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: poc-nignx
    spec:
      containers:
      - image: nignx
        name: nignx
        ports:
        - containerPort: 80
        resources: {}
status: {}
```


## Service
```
❯ kubectl create service clusterip poc-nignx  --tcp=8080:80 --dry-run=client -oyaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: poc-nignx
  name: poc-nignx
spec:
  ports:
  - name: 8080-80
    port: 8080
    protocol: TCP
    targetPort: 80
  selector:
    app: poc-nignx
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