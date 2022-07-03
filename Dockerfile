FROM debian:11.3

ENV PROJECT_ENV=dev SYMFONY_ENV=dev GID=0 UID=0

COPY entrypoint.sh /root/entrypoint.sh

RUN apt-get clean && apt-get update -qq && apt-get install -qqy --no-install-recommends \
        curl \
        make \
        git \
        apt-transport-https \
        ca-certificates \
        gnupg \
        gnupg2 \
        software-properties-common \
        sudo \
        openssl \
        nano \
        openssh-server \
        netcat \
        jq \
        lsb-release \
    && echo "alias ll='ls -la --color=auto'" >> /root/.bashrc \
    && mkdir -p /root/.composer/cache \
    && mkdir -p /root/.ssh \
    && echo "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get clean && apt-get update -qq && apt-get install -qqy  --no-install-recommends docker-ce \
    && curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && /usr/local/bin/docker-compose --version \
    && chmod +x /root/entrypoint.sh \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/root/entrypoint.sh"]
