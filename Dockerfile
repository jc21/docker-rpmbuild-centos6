FROM centos:6

MAINTAINER Jamie Curnow <jc@jc21.com>

# Yum
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm && \
	yum localinstall -y --nogpgcheck http://download1.rpmfusion.org/free/el/updates/6/i386/rpmfusion-free-release-6-1.noarch.rpm http://download1.rpmfusion.org/nonfree/el/updates/6/i386/rpmfusion-nonfree-release-6-1.noarch.rpm && \
	yum -y update && \
	yum -y install rpmdevtools mock rpmlint git wget curl kernel-devel rpmdevtools rpmlint rpm-build sudo gcc-c++ make

# Rust
RUN curl -sSf https://static.rust-lang.org/rustup.sh | sh -s -- --channel=nightly --disable-sudo -y

# build files
ADD bin/build-spec /bin/
ADD bin/build-all /bin/

# Sudo
ADD etc/sudoers.d/wheel /etc/sudoers.d/
RUN chown root:root /etc/sudoers.d/*

# Remove requiretty from sudoers main file
RUN sed -i '/Defaults    requiretty/c\#Defaults    requiretty' /etc/sudoers

# Rpm User
RUN adduser -G wheel rpmbuilder
ADD .rpmmacros /home/rpmbuilder/
USER rpmbuilder

WORKDIR /home/rpmbuilder
