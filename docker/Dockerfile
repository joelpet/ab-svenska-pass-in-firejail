FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      firejail \
      make \
      shellcheck

WORKDIR /mnt
CMD make