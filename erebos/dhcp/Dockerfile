FROM alpine:latest

LABEL version="0.0.1" \
      maintainer="bproesmans@hotmail.com" \
      source="https://github.com/Bert-Proesmans/chaos"

# NOTE; Kea depends on C++ compiler, make, libtool, boost (at least includes, but many
# OSes require boost-system library), log4cplus and one crypto library (either
# OpenSSL or Botan) for compilation.
#
# More information can be found at https://gitlab.isc.org/isc-projects/kea/blob/master/INSTALL

# DEBUG; Bash is for interactive debugging purposes. Remove it on release!
RUN apk update && \
    apk add --no-cache kea-dhcp4~=1.5.0-r2 \
        bash bash-completion \
        --repository="http://dl-cdn.alpinelinux.org/alpine/edge/main" \
        --repository="http://dl-cdn.alpinelinux.org/alpine/edge/testing" \
        --repository="http://dl-cdn.alpinelinux.org/alpine/edge/community"

COPY kea-dhcp4.jsonc /etc/kea/kea-dhcp4.conf

EXPOSE 67/udp
ENTRYPOINT [ "/usr/sbin/kea-dhcp4" ]
CMD ["-c","/etc/kea/kea-dhcp4.conf"]