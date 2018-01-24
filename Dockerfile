FROM docker:git

RUN apk --update add curl make py-pip \
    && pip install docker-compose \
    && mkdir -p /root/.composer/cache \
    && mkdir -p /root/.ssh \
    && sh -c '[[ -f /.dockerenv ]] && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config'

ENV PROJECT_ENV=dev SYMFONY_ENV=dev GID=0 UID=0