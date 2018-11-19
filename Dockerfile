FROM quay.io/water-hole/ansible-operator

USER root

RUN curl -Lf http://storage.googleapis.com/kubernetes-release/release/v1.10.7/bin/linux/amd64/kubectl -o /usr/bin/kubectl
RUN curl -Lf https://apb-oc.s3.amazonaws.com/apb-oc/oc-linux-64bit.tar.gz | tar xzv --directory /usr/bin --wildcards "*/oc" --strip-components=1
RUN chmod 755 /usr/bin/kubectl
RUN chmod 755 /usr/bin/oc

COPY ansible/roles/ /opt/ansible/roles/
COPY ansible/cdi_provision.yaml /opt/ansible/cdi_provision.yaml
COPY ansible/cdi_deprovision.yaml /opt/ansible/cdi_deprovision.yaml

COPY watches.yaml /opt/ansible/watches.yaml

RUN adduser cdi-operator
RUN chown -R cdi-operator: /opt/ansible
USER cdi-operator

