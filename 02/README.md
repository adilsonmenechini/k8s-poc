# 01 Exemplo

## Pod
```

```


## Deployment

### Request/limits (CPU/MEM)
```
        resources:
          requests:
            memory: "64Mi"
            cpu: "50m"
          limits:
            memory: "128Mi"
            cpu: "250m"
```


## Service
```

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


## HPA

### CPU/MEM

- A utilização de CPU média alvo é de 80% e a alocação de memória média alvo é de 200Mi.

```
spec:
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 90 #Porcentagem
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageValue: 200Mi #Media

```
### behavior 

(ScaleUP/ScaleDown)

- políticas de estabilização de janela de 300 segundos,  antes de fazer outra ajuste de escalonamento
```
scaleDown:
  stabilizationWindowSeconds: 300
```
- Os comportamentos de escalonamento para scaleUP e scaleDown e para baixo especificam tipos de percentual, o que significa que o HPA irá escalar o número de réplicas em 100% ou 50% da diferença entre o número de réplicas atual e o número de réplicas alvo. Isso permite que o HPA faça ajustes de escalonamento mais rápidos ou mais lentos, dependendo da configuração
```
policies:
  - type: Percent
    value: 25
    periodSeconds: 60
```
Overview
```
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300
      policies:
        - type: Percent
          value: 25
          periodSeconds: 60
    scaleUp:
      stabilizationWindowSeconds: 100
      policies:
        - type: Percent
          value: 25
          periodSeconds: 60

```

### horizontal Pod Autoscaler Schedule

- O primeiro é ativado a cada 5 minutos, e ajusta o número mínimo de réplicas para 5 e o número máximo de réplicas para 20.
- O segundo é ativado às 0 horas de cada dia, e ajusta o número mínimo de réplicas para 1 e o número máximo de réplicas para 5.

```
spec:
  horizontalPodAutoscalerSchedule:
    - schedule: '*/5 * * * *'
      minReplicas: 5
      maxReplicas: 20
    - schedule: '0 * * * *'
      minReplicas: 1
      maxReplicas: 5
```


### External Metrics

```
- type: External
  external:
    metric:
      name: timeshift(sum:azure.servicebus_namespaces.incoming_messages{name:example-sbus-prod-brazilsouth,entityname:promax_example} by {entityname}.as_count(), -300)
      selector:
        matchLabels:
          app: teste
    target:
      type: AverageValue
      averageValue: 1000
```

## Overview

```
❯ kubectl apply -f metrics-server.yaml
❯ kubectl apply -f namespace.yaml
namespace/ns-poc created
❯ kubectl apply -f deployment.yaml -n ns-poc
deployment.apps/poc-nginx created
❯ kubectl apply -f service.yaml -n ns-poc
service/poc-nginx created
❯ kubectl apply -f hpa.yaml -n ns-poc
horizontalpodautoscaler.autoscaling/poc-nginx created
❯ kubectl get pod,deploy,service,ep,hpa -n ns-poc
NAME                             READY   STATUS    RESTARTS   AGE
pod/poc-nginx                    1/1     Running   0          22m
pod/poc-nginx-7cb6f64f96-gnf9q   1/1     Running   0          22m

NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/poc-nginx   1/1     1            1           22m

NAME                TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/poc-nginx   ClusterIP   10.96.138.18   <none>        8080/TCP   22m

NAME                  ENDPOINTS                   AGE
endpoints/poc-nginx   10.1.0.29:80,10.1.0.30:80   22m

NAME                                            REFERENCE              TARGETS                        MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/poc-nginx   Deployment/poc-nginx   1998848/200Mi, <unknown>/90%   1         4         1          22m
```
