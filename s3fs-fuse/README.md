
# How To Use

```
docker run -d --privileged \
    -e GCS_BUCKET_NAME=<BUCKET NAME> \
    -e GCS_ACCESS_KEY=<ACCESS_KEY> \
    -e GCS_ACCESS_SECRET=<ACCESS_SECRET> \
    -p 8080:80 \
    --name s3fs-fuse \
    s3fs-fuse
```

