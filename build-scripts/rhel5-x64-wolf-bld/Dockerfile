FROM wolframe/rhel5-x64-wolf-dev
MAINTAINER abaumann@yahoo.com

ENV HOME /root
RUN ln -s /usr/src/redhat /root/rpmbuild
WORKDIR /root
RUN wget http://sourceforge.net/projects/wolframe/files/wolframe/wolframe-0.0.2.tar.gz
RUN tar zxvf wolframe-0.0.2.tar.gz
WORKDIR /root/wolframe-0.0.2
ENV OSB_PLATFORM centos_version 510
RUN packaging/redhat/buildlocal.sh

CMD /bin/bash
