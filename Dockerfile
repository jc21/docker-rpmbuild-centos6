FROM jc21/rpmbuild-centos6:latest

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

USER root

# C++11 Compiler
RUN wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo \
    && yum -y upgrade \
    && yum -y install devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++
ADD etc/profile.d/enablecpp.sh /etc/profile.d/enablecpp.sh

USER rpmbuilder

