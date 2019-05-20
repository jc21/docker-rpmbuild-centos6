FROM jc21/rpmbuild-centos6:latest

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

USER root

# jc21 yum and golang 1.12+
RUN yum localinstall -y https://yum.jc21.com/jc21-yum.rpm \
 && yum -y update \
 && yum -y install golang \
 && yum clean all \
 && rm -rf /var/cache/yum

USER rpmbuilder

