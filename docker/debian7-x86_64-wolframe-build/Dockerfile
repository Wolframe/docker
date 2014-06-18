FROM wolframe/debian7-x86_64-wolframe-develop
MAINTAINER abaumann@yahoo.com

ENV HOME /root
WORKDIR /root
RUN wget http://andreasbaumann.dyndns.org/wolframe-0.0.1.tar.gz
RUN tar zxvf wolframe-0.0.1.tar.gz
WORKDIR /root/wolframe-0.0.1
RUN ln -s packaging/debian debian
RUN dpkg-buildpackage -us -uc

CMD /bin/bash
