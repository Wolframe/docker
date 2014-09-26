FROM wolframe/ub1404-x64-wolf-dev
MAINTAINER abaumann@yahoo.com

ENV HOME /root
WORKDIR /root
RUN wget http://sourceforge.net/projects/wolframe/files/wolframe/wolframe-0.0.3.tar.gz
RUN tar zxvf wolframe-0.0.3.tar.gz
WORKDIR /root/wolframe-0.0.3
RUN ln -s packaging/debian debian
RUN dpkg-buildpackage -us -uc

CMD /bin/bash
