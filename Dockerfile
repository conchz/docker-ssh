FROM daocloud.io/centos:7

MAINTAINER Baymax <dolphineor@gmail.com>

RUN yum install -y openssh-server sudo
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

RUN useradd admin
RUN echo "admin:admin" | chpasswd
RUN echo "admin    ALL=(ALL)    ALL" >> /etc/sudoers

RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

RUN mkdir /var/run/sshd

RUN echo -e "[mongodb-org-3.4]\nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.4/x86_64/\ngpgcheck=1\nenabled=1\ngpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc" > /etc/yum.repos.d/mongodb-org-3.4.repo
RUN echo -e "[nginx]\nname=nginx repo\nbaseurl=http://nginx.org/packages/centos/7/$basearch/\ngpgcheck=1\nenabled=1" > /etc/yum.repos.d/nginx.repo

RUN curl http://nginx.org/keys/nginx_signing.key -o nginx_signing.key
RUN sudo rpm --import nginx_signing.key
RUN sudo rm -f nginx_signing.key
RUN sudo yum update -y
RUN sudo yum install -y mongodb-org nginx vim net-tools

EXPOSE 22 80
CMD ["/usr/sbin/sshd", "-D"]

