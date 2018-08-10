FROM jc21/rpmbuild-centos6:latest

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

# Golang
RUN sudo yum -y install golang \
    && sudo yum clean all

