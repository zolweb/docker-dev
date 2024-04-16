FROM debian:12.5

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
        netcat-traditional \
        jq \
        lsb-release \
        zip \
    && echo "alias ll='ls -la --color=auto'" >> /root/.bashrc \
    && mkdir -p /root/.composer/cache \
    && mkdir -p /root/.ssh \
    && echo "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get clean && apt-get update -qq && apt-get install -qqy --no-install-recommends docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
    && chmod +x /root/entrypoint.sh \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt \
    && sed -i 's/ulimit -Hn/# ulimit -Hn/g' /etc/init.d/docker;
    # See https://github.com/docker/cli/issues/4807 for the ulimit fix

ENTRYPOINT ["/root/entrypoint.sh"]
