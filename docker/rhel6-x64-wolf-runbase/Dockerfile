FROM wolframe/rhel6-x64-base
MAINTAINER abaumann@yahoo.com

RUN wget http://mirror.switch.ch/ftp/mirror/epel/6/i386/epel-release-6-8.noarch.rpm
RUN yum -y localinstall epel-release-6-8.noarch.rpm
RUN yum -y install vim joe shadow-utils telnet
RUN wget -O /etc/yum.repos.d/wolframe.repo http://sourceforge.net/projects/wolframe/files/repositories/CentOS-6/wolframe.repo
RUN yum -y install wolframe

ENTRYPOINT ["/usr/sbin/wolframed", "-f", "-c", "/etc/wolframe/wolframe.conf"]

EXPOSE 7661
