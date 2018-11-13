# mysql with centos6
FROM daocloud.io/library/centos:centos7
LABEL author="JiYun Tech Team <mboss0@163.com>"

ADD ./start.sh /start.sh
ADD ./supervisord.conf /etc/supervisord.conf

RUN yum -y update;yum clean all \
    && yum -y install epel-release;yum clean all \
    && yum -y install supervisor;yum clean all \
    && chmod -R 777 /usr/games \
    && chmod 755 /start.sh

WORKDIR /usr/games

EXPOSE 7777
ENTRYPOINT [ "/start.sh" ]
