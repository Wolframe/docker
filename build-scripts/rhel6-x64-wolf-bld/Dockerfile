FROM wolframe/rhel6-x64-wolf-dev
MAINTAINER abaumann@yahoo.com

ENV HOME /root
RUN mkdir -p /root/rpmbuild/{BUILD,RPMS,RPMS/noarch,RPMS/x86_64,SOURCES,SPECS,SRPMS}
WORKDIR /root
RUN wget http://sourceforge.net/projects/wolframe/files/wolframe/wolframe-0.0.3.tar.gz
RUN tar zxvf wolframe-0.0.3.tar.gz
WORKDIR /root/wolframe-0.0.3
ENV OSB_PLATFORM centos_version 605
RUN packaging/redhat/buildlocal.sh

CMD /bin/bash
