FROM alpine:3.6

RUN adduser -D cdi-operator
USER cdi-operator

ADD tmp/_output/bin/cdi-operator /usr/local/bin/cdi-operator
