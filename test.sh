ci/wait-pods-ok
make build
make deploy
# give everything time to come up - PLEASE FIX
sleep 120
# fetch operator logs
oc logs $(oc get pods --selector name=cdi-operator --output=name)
# check for CDI related pods in kube-system ns
oc get pod -o name --namespace=kube-system | grep cdi
