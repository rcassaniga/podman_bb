FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV USER_UID=1000
ENV USER_GID=1000
ENV USERNAME=user

#
# Mininum packages for installing
#
RUN ln -sf /bin/true /usr/bin/chfn && apt-get update && \
    apt-get install -y --no-install-recommends \
# It is strange but warsaw dependends on systemd-sysv with pam and nss
    systemd-sysv \
    libpam-systemd \
    libnss-systemd \
# libcurl and certificates are also for warsaw.
    libcurl3-nss \
    ca-certificates \
# This dependency is also for warsaw. This is the strangest thing
    libgtk2.0-0 \
    firefox
#
# Below the dependencies on warsaw deb package.
#
RUN apt-get install -y --no-install-recommends \
    libdbus-1-3 \
    procps \
    zenity \
    python3

#
# Debug
#
#RUN apt-get install -y --no-install-recommends \
#    xauth \
#    x11-apps \
#    vim

# We are going to install warsaw from CEF. It works for BB.
# sha256sum of the latest test deb package: sha256sum warsaw_setup64.deb
# 54601df0711ede3a0c8b72f8b408b20309fa41874af0aa465499358ba8c04cc5
ADD https://cloud.gastecnologia.com.br/cef/warsaw/install/GBPCEFwr64.deb /src/warsaw.deb

RUN groupadd -g ${USER_GID} ${USERNAME} && \
    useradd -u ${USER_UID} -g ${USER_GID} -ms /bin/bash user && \
    mkdir /home/${USERNAME}/Downloads && \
    chown -R ${USERNAME}.${USERNAME} /home/${USERNAME}

COPY context/firefox.service /etc/systemd/system/
COPY context/startbrowser.sh /usr/local/bin/

RUN mkdir -p /var/run/dbus && \
	systemctl enable firefox && \
	systemctl disable systemd-resolved && \
        systemctl disable systemd-tmpfiles-setup.service

STOPSIGNAL SIGRTMIN+3

ENTRYPOINT [ "/sbin/init" ]

