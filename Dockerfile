# Define the names/tags of the container
#!BuildTag: opensuse/opensuse-mirror:latest opensuse/opensuse-mirror:0.9 opensuse/opensuse-mirror:0.9.%RELEASE%

FROM opensuse/tumbleweed

# Define labels according to https://en.opensuse.org/Building_derived_containers
# labelprefix=org.opensuse.example
PREFIXEDLABEL org.opencontainers.image.title="openSUSE Mirror"
PREFIXEDLABEL org.opencontainers.image.description="Simple to deploy home mirror in a container 0.9"
PREFIXEDLABEL org.opensuse.reference="registry.opensuse.org/opensuse/opensuse-mirror:0.9.%RELEASE%"
PREFIXEDLABEL org.openbuildservice.disturl="%DISTURL%"
PREFIXEDLABEL org.opencontainers.image.created="%BUILDTIME%"

USER root
WORKDIR /root

# All profiles are listed here
# https://github.com/openSUSE/opensuse-hotstuff/tree/main/etc/rsyncd.d
# https://mirrors.opensuse.org/list/rsyncinfo-stage.o.o.txt
# ENV is processed by mirror-sync.sh
#ARG mirror_module=opensuse-full
ARG mirror_module=opensuse-hotstuff-hackweek
ENV MIRROR_MODULE=$mirror_module

RUN zypper --non-interactive in rsync nginx cron cronie withlock python && zypper clean -a

COPY nginx.conf /etc/nginx

COPY mirror-sync.sh /root/mirror-sync.sh
COPY mirror-exclude.lst /root/mirror-exclude.lst
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod 755 /root/mirror-sync.sh /root/entrypoint.sh

# Periodical refresh of mirror
COPY cronjob /root/cronjob
RUN crontab /root/cronjob

# Please use volume for /srv/pub/opensuse
RUN mkdir -p /srv/pub/opensuse

ENTRYPOINT ["./entrypoint.sh"]
