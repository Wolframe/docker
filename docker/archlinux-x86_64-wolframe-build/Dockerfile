FROM wolframe/archlinux-x86_64-wolframe-develop
MAINTAINER abaumann@yahoo.com

ENV HOME /root
WORKDIR /root
RUN wget http://andreasbaumann.dyndns.org/wolframe-0.0.1.tar.gz
RUN tar zxvf wolframe-0.0.1.tar.gz
WORKDIR /root/wolframe-0.0.1
RUN packaging/archlinux/buildlocal.sh

CMD /bin/bash
