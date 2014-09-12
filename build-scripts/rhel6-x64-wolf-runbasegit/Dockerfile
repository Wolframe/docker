FROM wolframe/rhel6-x64-base
MAINTAINER abaumann@yahoo.com

RUN wget -O /etc/yum.repos.d/wolframe.repo http://download.opensuse.org/repositories/home:wolframe_user/CentOS_CentOS-6/home:wolframe_user.repo
RUN yum -y install wolframe

CMD ["/usr/sbin/wolframed", "-f", "-c", "/etc/wolframe/wolframe.conf"]

EXPOSE 7661
