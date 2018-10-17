SHELL=/bin/bash -o pipefail

REPO?=docker.io/kubevirt/cdi-operator
TAG?=latest

##############
# Deploy     #
##############

setprivileges:
	# Give the cdi operator user 'default' cluster-admin privileges
	oc adm policy add-cluster-role-to-user cluster-admin -z default

deploy: setprivileges
	# Deploy the cdi-operator
	kubectl create -f deploy/rbac.yaml
	kubectl create -f deploy/crd.yaml
	kubectl create -f deploy/operator.yaml
	# Create the operator resource (kubectl get apps)
	kubectl create -f deploy/cr.yaml

##############
# Undeploy   #
##############

undeploy:
	# Undeploy the app-operator
	kubectl delete -f deploy/crd.yaml --ignore-not-found
	kubectl delete -f deploy/operator.yaml --ignore-not-found
	kubectl delete -f deploy/rbac.yaml --ignore-not-found

##############
# CR        #
##############

cr:
	# Temporary Hack: Need to fix rbac
	oc adm policy add-cluster-role-to-user -z cdi-operator cluster-admin
	oc create -f deploy/cr.yaml

##############
# OLM        #
##############

olm:
	oc create -f cdi-operator-configmap.yaml -f cdi-catalog-source.yaml

rm-olm:
	oc delete -f cdi-operator-configmap.yaml -f cdi-catalog-source.yaml

##############
# Build      #
##############

build:
	docker build -t $(REPO):$(TAG) -f Dockerfile .

push:
	docker push $(REPO):$(TAG)

.PHONY:  build push undeploy deploy olm rm-olm cr
