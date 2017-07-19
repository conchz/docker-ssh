FROM daocloud.io/centos:7

MAINTAINER Baymax <dolphineor@gmail.com>

RUN yum install -y openssh-server sudo
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

RUN useradd admin
RUN echo "admin:admin" | chpasswd
RUN echo "admin    ALL=(ALL)    ALL" >> /etc/sudoers

RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

RUN mkdir /var/run/sshd && mkdir ~/.pip
RUN echo -e "[global]\nindex-url=http://mirrors.aliyun.com/pypi/simple/\n[install]\ntrusted-host=mirrors.aliyun.com" > ~/.pip/pip.conf
RUN echo -e "[mongodb-org-3.4]\nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.4/x86_64/\ngpgcheck=1\nenabled=1\ngpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc" > /etc/yum.repos.d/mongodb-org-3.4.repo

RUN yum install -y wget vim yum-utils apache2-utils net-tools nmap mongodb-org
RUN yum install -y python-setuptools
RUN easy_install -i http://mirrors.aliyun.com/pypi/simple/ pip
RUN pip install supervisor

EXPOSE 22 27017 28017
CMD ["/usr/sbin/sshd", "-D"]

