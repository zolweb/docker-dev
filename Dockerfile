FROM gitlab/dind:latest

RUN apt-get update -qq && apt-get install -qqy curl make git \
    && mkdir -p /root/.composer/cache \
    && mkdir -p /root/.ssh \
    && bash -c '[[ -f /.dockerenv ]] && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config' \
    && curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && /usr/local/bin/docker-compose --version

ENV PROJECT_ENV=dev SYMFONY_ENV=dev GID=0 UID=0