#!/bin/bash

rm -rf default.etcd

etcdctl snapshot restore ${SNAPSHOT_FILE} \
  --name default \
  --initial-advertise-peer-urls="http://localhost:2380" \
  --initial-cluster="default=http://localhost:2380" \
  --initial-cluster-token="etcd-cluster"

etcd \
  --name default \
  --listen-client-urls http://localhost:2379 \
  --advertise-client-urls http://localhost:2379 \
  --listen-peer-urls http://localhost:2380 \
  --force-new-cluster &

until etcdctl --cluster=true endpoint health; do
  echo "Waiting for cluster starting..."
  sleep 1
done

