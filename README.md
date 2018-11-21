# cdi-operator
Operator that manages CDI (containerized-data-importer)

## Quick Start

### Prerequisites

- Docker (used for creating container images, etc.) with access for the current user
- a Kubernetes/OpenShift/Minikube/Minishift instance

### Build a local docker image for the operator
```make build```

### Launch the Operator in the local Openshift Cluster
```make deploy```

### Check operator logs
```oc logs -f $(oc get pods  --selector name=cdi-operator --output=name)```

### Check for CDI related pods in kube-system ns
```oc get pod -o name --namespace=kube-system | grep cdi```
