# mysql with centos6
FROM daocloud.io/library/centos:centos7
LABEL author="JiYun Tech Team <mboss0@163.com>"

ADD ./start.sh /start.sh
ADD ./supervisord.conf /etc/supervisord.conf

RUN yum -y update;yum clean all \
    && yum -y install epel-release;yum clean all \
    && yum -y install supervisor;yum clean all \
    && groupadd -r mono && useradd -s /sbin/nologin -M -r -g mono mono \
    && rpm --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF" \
    && su -c 'curl https://download.mono-project.com/repo/centos6-stable.repo | tee /etc/yum.repos.d/mono-centos6-stable.repo' \
    && yum -y install mono-devel;yum clean all \
    && chown -R mono:mono /usr/games \
    && chmod -R 777 /usr/games \
    && chmod 755 /start.sh

WORKDIR /usr/games

EXPOSE 7777
ENTRYPOINT [ "/start.sh" ]
