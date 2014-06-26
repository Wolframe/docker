FROM wolframe/rhel5-x64-base
MAINTAINER abaumann@yahoo.com

WORKDIR /root
RUN wget http://mirror.switch.ch/ftp/mirror/epel/5/x86_64/epel-release-5-4.noarch.rpm
RUN wget http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-5
RUN rpm -v --import RPM-GPG-KEY-EPEL-5
RUN yum -y localinstall epel-release-5-4.noarch.rpm
RUN yum -y install make gcc gcc-c++ rpm-build tar ccache distcc
