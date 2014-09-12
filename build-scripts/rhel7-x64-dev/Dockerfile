FROM wolframe/rhel7-x64-base
MAINTAINER abaumann@yahoo.com

WORKDIR /root
RUN wget http://mirror.switch.ch/ftp/mirror/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm
RUN wget http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
RUN rpm -v --import RPM-GPG-KEY-EPEL-7
RUN yum -y localinstall epel-release-7-0.2.noarch.rpm
RUN yum -y install make gcc gcc-c++ rpm-build tar ccache distcc
