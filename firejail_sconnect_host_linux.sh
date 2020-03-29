#!/bin/bash

set -x -eu -o pipefail

net_iface="$(ip route | awk '/^default via .+ dev/ { print $5 }')"

if [[ -z "${net_iface}" ]]; then
  echo >&2 "No network interface found"
  exit 1
fi

declare -a args

args+=('--quiet')
args+=("--net=${net_iface}")
args+=('--nodbus')
args+=('--no3d')
args+=('--nodvd')
args+=('--nosound')
args+=('--notv')
args+=('--nou2f')
args+=('--novideo')
args+=('--private')
args+=('--private-dev')
args+=('--private-home=.sconnect')
args+=('--x11=none')

if [[ "${1:-}" == "run-audit" ]]; then
    args+=('--audit')
    host_file_path=/bin/false
else
    host_file_path="${HOME}/.sconnect/sconnect_host_linux-nonfree"
fi

firejail "${args[@]}" "${host_file_path}"
