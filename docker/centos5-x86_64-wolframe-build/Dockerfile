FROM wolframe/centos5-x86_64-wolframe-develop
MAINTAINER abaumann@yahoo.com

ENV HOME /root
RUN ln -s /usr/src/redhat /root/rpmbuild
WORKDIR /root
RUN wget http://andreasbaumann.dyndns.org/wolframe-0.0.1.tar.gz
RUN tar zxvf wolframe-0.0.1.tar.gz
WORKDIR /root/wolframe-0.0.1
ENV OSB_PLATFORM centos_version 510
RUN packaging/redhat/buildlocal.sh

CMD /bin/bash
