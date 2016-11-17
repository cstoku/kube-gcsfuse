FROM alpine:3.4
MAINTAINER tokuda_takuya@griphone.co.jp

ENV BUILD_DEPS \
    git \
    wget \
    build-base \
    fuse-dev \
    automake \
    autoconf \
    g++ \
    libssl1.0 \
    libxml2-dev \
    curl-dev \
    make \
    pkgconfig

ENV RUN_PACKAGE \
    nginx

RUN set -xe && \
    apk add --no-cache --virtual .builddeps $BUILD_DEPS && \
    cd /tmp && \
    git clone https://github.com/s3fs-fuse/s3fs-fuse.git && \
    cd s3fs-fuse && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    runDeps="$( \
        scanelf --needed --nobanner --recursive /usr/local \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | sort -u \
            | xargs -r apk info --installed \
            | sort -u \
        )" && \
    apk add --no-cache --virtual .rundeps $runDeps $RUN_PACKAGE && \
    apk del --no-cache .builddeps && \
    rm -rf /tmp/* && \
    mkdir -p /run/nginx

COPY docker-entrypoint.sh /usr/local/bin

EXPOSE 80
ENTRYPOINT ["docker-entrypoint.sh"]
