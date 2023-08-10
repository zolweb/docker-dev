FROM docker:24.0.5-dind

ENV PROJECT_ENV=dev SYMFONY_ENV=dev GID=0 UID=0

RUN apk update && apk add \
        curl \
        make \
        git \
        # apt-transport-https \
        ca-certificates \
        gnupg \
        sudo \
        openssl \
        nano \
        openssh-server \
        netcat-openbsd \
        jq \
        lsb-release \
        zip 

RUN echo "alias ll='ls -la --color=auto'" >> /root/.bashrc \
    && mkdir -p /root/.composer/cache \
    && mkdir -p /root/.ssh \
    && echo "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config 
