FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      make \
      shellcheck

WORKDIR /mnt
CMD make