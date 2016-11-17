#!/bin/sh

# env check
if [ -z $GCS_ACCESS_KEY ]; then
    echo "Empty GCS_ACCESS_KEY..." >&2
    exit 1
fi
if [ -z $GCS_ACCESS_SECRET ]; then
    echo "Empty GCS_ACCESS_SECRET..." >&2
    exit 1
fi
if [ -z $GCS_BUCKET_NAME ]; then
    echo "Empty GCS_BUCKET_NAME..." >&2
    exit 1
fi

# make mount point
mkdir -p /mnt/gcs/$GCS_BUCKET_NAME

# make credential file
mkdir -p /etc/gcs
if [ ! -e /etc/gcs/credential ]; then
    echo "$GCS_ACCESS_KEY:$GCS_ACCESS_SECRET" > /etc/gcs/credential
    chmod 400 /etc/gcs/credential
fi

# mount gcs
s3fs $GCS_BUCKET_NAME /mnt/gcs/$GCS_BUCKET_NAME \
    -o passwd_file=/etc/gcs/credential \
    -o url=https://storage.googleapis.com \
    -o default_acl=public_read \
    -o  allow_other \
    -o sigv2 \
    -o nomultipart

# mount gcs
if [ -L /var/lib/nginx/html ]; then
    rmdir /var/lib/nginx/html
else
    rm -rf /var/lib/nginx/html
fi
ln -sfn /mnt/gcs/$GCS_BUCKET_NAME /var/lib/nginx/html

# main process
nginx -g "daemon off;"

# unmount
fusermount /mnt/gcs/$GCS_BUCKET_NAME
