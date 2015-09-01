FROM centos:6

MAINTAINER Jamie Curnow <jc@jc21.com>

# build files
ADD .rpmmacros /root/
ADD build-spec /bin/
ADD build-all /bin/

# Yum
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm && \
	yum localinstall -y --nogpgcheck http://download1.rpmfusion.org/free/el/updates/6/i386/rpmfusion-free-release-6-1.noarch.rpm http://download1.rpmfusion.org/nonfree/el/updates/6/i386/rpmfusion-nonfree-release-6-1.noarch.rpm && \
	yum -y update && \
	yum -y install rpmdevtools mock rpmlint git wget curl kernel-devel rpmdevtools rpmlint rpm-build

# Rust
RUN curl -sSf https://static.rust-lang.org/rustup.sh | sh -s -- --channel=nightly --disable-sudo -y

# Rpm User
RUN adduser rpmbuilder

# Switch to user
RUN su rpmbuilder -

WORKDIR /home/rpmbuilder
