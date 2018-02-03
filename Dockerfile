FROM gitlab/dind:latest

RUN apt-get update -qq && apt-get install -qqy curl make git \
    && mkdir -p /root/.composer/cache \
    && mkdir -p /root/.ssh \
    && bash -c '[[ -f /.dockerenv ]] && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config'

ENV PROJECT_ENV=dev SYMFONY_ENV=dev GID=0 UID=0