FROM debian:9.4

RUN apt-get clean && apt-get update -qq && apt-get install -qqy \
        curl \
        make \
        git \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common \
    && mkdir -p /root/.composer/cache \
    && mkdir -p /root/.ssh \
    && bash -c '[[ -f /.dockerenv ]] && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config'

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee -a /etc/apt/sources.list.d/docker.list

RUN apt-get clean && apt-get update -qq && apt-get install -qqy docker-ce

RUN curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && /usr/local/bin/docker-compose --version

ENV PROJECT_ENV=dev SYMFONY_ENV=dev GID=0 UID=0

COPY entrypoint.sh /root/entrypoint.sh

RUN chmod +x /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]