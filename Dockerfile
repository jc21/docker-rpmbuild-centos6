FROM jc21/rpmbuild-centos6:latest

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

USER root

# Golang
RUN yum -y install golang \
    && yum clean all

USER rpmbuilder

