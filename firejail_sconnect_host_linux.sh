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

log_file_path="${HOME}/.sconnect/$(basename "$0").log"
err_file_path="${HOME}/.sconnect/$(basename "$0").err"

{ firejail "${args[@]}" "${host_file_path}" | tee "${log_file_path}"; } 2>"${err_file_path}" \
    || notify-send "$0" "The firejail command failed. See logs for more details."
