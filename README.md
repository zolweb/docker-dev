# Descriptions

This repository describe a simple image from [gitlab/dind](https://hub.docker.com/r/gitlab/dind/) with added tools.

The purpose is to update a little bit the gitlab/dind image to add some tools (make, curl) and update docker-compose binary

Make sure you use the option `--docker-privileged` when registering your runner (or specifying in runner configuration in `/etc/gitlab-runner/config.toml`) to make this image able to run docker containers