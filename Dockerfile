FROM centos:6

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

# Yum
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm && \
    yum -y update && \
    yum -y install rpmdevtools mock rpmlint git wget curl kernel-devel rpmdevtools rpmlint rpm-build sudo gcc-c++ make automake autoconf expect

# Update autoconf
RUN cd /tmp \
    && curl -L -O http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz \
    && tar zxf autoconf-2.69.tar.gz \
    && cd autoconf-2.69 \
    && yum install -y openssl-devel \
    && ./configure \
    && make \
    && make install \
    && cd /tmp \
    && rm -rf autoconf*

# build files
ADD bin/build-spec /bin/
ADD bin/build-all /bin/

# Sudo
ADD etc/sudoers.d/wheel /etc/sudoers.d/
RUN chown root:root /etc/sudoers.d/*

# Remove requiretty from sudoers main file
RUN sed -i '/Defaults    requiretty/c\#Defaults    requiretty' /etc/sudoers

# Rpm User
RUN adduser -G wheel rpmbuilder \
    && mkdir -p /home/rpmbuilder/rpmbuild/{BUILD,SPECS,SOURCES,BUILDROOT,RPMS,SRPMS,tmp} \
    && chmod -R 777 /home/rpmbuilder/rpmbuild

# Add another user and group with 1000 so that rpm won't complain about bad owner/group when building on default el7 boxes
RUN groupadd -g 1000 el7 \
    && useradd -u 1000 -g el7 -G wheel el7

ADD .rpmmacros /home/rpmbuilder/
USER rpmbuilder

WORKDIR /home/rpmbuilder
