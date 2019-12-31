#!/bin/bash

set -x -eu -o pipefail

net_iface="$(ip route | awk '/^default via .+ dev/ { print $5 }')"

if [[ -z "${net_iface}" ]]; then
  echo >&2 "No network interface found"
  exit 1
fi

firejail \
  --quiet \
  --net="${net_iface}" \
  --no3d \
  --nodvd \
  --nosound \
  --notv \
  --nou2f \
  --novideo \
  --private \
  --private-dev \
  --private-home=.sconnect \
  ~/.sconnect/sconnect_host_linux-nonfree
