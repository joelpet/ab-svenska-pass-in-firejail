#!/bin/bash

set -x -eu -o pipefail

net_iface="$(ip route | awk '/^default via .+ dev/ { print $5 }')"

if [[ -z "${net_iface}" ]]; then
  echo >&2 "No network interface found"
  exit 1
fi

host_file_path="$HOME/.sconnect/sconnect_host_linux-nonfree"

if [[ "$1" == "run-audit" ]]; then
    audit="--audit"
    host_file_path=/bin/false
fi

firejail \
  --quiet \
  --net="${net_iface}" \
  --nodbus \
  --no3d \
  --nodvd \
  --nosound \
  --notv \
  --nou2f \
  --novideo \
  --private \
  --private-dev \
  --private-home=.sconnect \
  --x11=none \
  "${audit}" \
  "${host_file_path}"
