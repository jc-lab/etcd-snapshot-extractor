#!/bin/bash

for name in $(etcdctl get "/registry" --keys-only --prefix); do
  dir="/output$(dirname ${name})"
  mkdir -p "${dir}"
  filepath="/output${name}"
  echo "${name}"
  if etcdctl get "${name}" -w simple --print-value-only | jq -e . >/dev/null 2>&1; then
    etcdctl get "${name}" -w simple --print-value-only > "${filepath}"
  else
    etcdctl get "${name}" -w simple --print-value-only | auger decode > "${filepath}"
  fi
done

