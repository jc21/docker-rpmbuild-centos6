FROM jc21/rpmbuild-centos6:latest

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

USER root

# rust
RUN yum -y install cmake \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && wget https://sh.rustup.rs -O /tmp/install-rust.sh \
    && chmod +x /tmp/install-rust.sh

USER rpmbuilder

RUN /tmp/install-rust.sh -y
