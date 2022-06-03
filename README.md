# etcd-snapshot-extractor

Extract etcd snapshot binary to JSON files.

# Usage

```bash
$ mkdir -p $output
$ docker run --rm \
    -v $PWD/snapshot.bin:/snapshot.bin:ro \
    -v $PWD/output:/output \
    ghcr.io/jc-lab/etcd-snapshot-extractor:latest
```

