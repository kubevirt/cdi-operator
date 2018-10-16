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
# Build      #
##############

build:
	docker build -t $(REPO):$(TAG) -f Dockerfile .

push:
	docker push $(REPO):$(TAG)

.PHONY:  build push undeploy deploy
