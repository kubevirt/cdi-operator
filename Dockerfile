FROM quay.io/water-hole/ansible-operator

USER root

RUN curl -Lf http://storage.googleapis.com/kubernetes-release/release/v1.10.7/bin/linux/amd64/kubectl -o /usr/bin/kubectl
RUN chmod 755 /usr/bin/kubectl

RUN adduser cdi-operator
RUN chown -R cdi-operator: /opt/ansible

USER cdi-operator

COPY ansible/roles/ /opt/ansible/roles/
COPY ansible/cdi.yaml /opt/ansible/cdi.yaml

COPY watches.yaml /opt/ansible/watches.yaml
