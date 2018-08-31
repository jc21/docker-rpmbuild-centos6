FROM jc21/rpmbuild-centos6:latest

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

USER root

# rust
RUN yum -y install cmake \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && curl -sSf https://static.rust-lang.org/rustup.sh | sh

USER rpmbuilder

