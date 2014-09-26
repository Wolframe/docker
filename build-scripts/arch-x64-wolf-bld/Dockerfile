FROM wolframe/arch-x64-wolf-dev
MAINTAINER abaumann@yahoo.com

ENV HOME /root
WORKDIR /root
RUN wget http://sourceforge.net/projects/wolframe/files/wolframe/wolframe-0.0.3.tar.gz
RUN tar zxvf wolframe-0.0.3.tar.gz
WORKDIR /root/wolframe-0.0.3
RUN packaging/archlinux/buildlocal.sh

CMD /bin/bash
