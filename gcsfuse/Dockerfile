FROM alpine:3.4
MAINTAINER tokuda_takuya@griphone.co.jp

ENV BUILD_DEPS \
    go \
    git \
    tar \
    wget \
    build-base \
    fuse-dev \
    curl-dev

ENV RUN_DEPS \
    fuse \
    curl \
    nginx

ENV GOPATH /tmp/go
ENV GO15VENDOREXPERIMENT 1

RUN set -xe && \
    apk add --no-cache $BUILD_DEPS $RUN_DEPS && \
    go get -u github.com/googlecloudplatform/gcsfuse && \
    mv $GOPATH/bin/gcsfuse /usr/local/bin && \
    apk del $BUILD_DEPS && \
    mkdir -p /run/nginx && \
    rm -rf /tmp/*

COPY docker-entrypoint.sh /usr/local/bin

EXPOSE 80
ENTRYPOINT ["docker-entrypoint.sh"]

