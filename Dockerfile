FROM quay.io/coreos/etcd:v3.4.18

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get -y install \
    golang-go make gcc git \
    curl

RUN mkdir -p /build && \
    cd /build && \
    git clone https://github.com/jpbetz/auger && \
    cd auger && \
    git checkout -f 21d4b35b8fe3b4e81aee41cc93269cbd4723fa21

RUN cd /build/auger && \
    make && \
    cp build/auger /usr/bin/auger

COPY ["restore-and-run.sh", "dump.sh", "/"]
RUN chmod +x /*.sh

ENV SNAPSHOT_FILE=/snapshot.bin

VOLUME /snapshot.bin
VOLUME /output

CMD ["sh", "-c", "/restore-and-run.sh && /dump.sh"]

