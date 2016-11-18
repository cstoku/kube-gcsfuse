
# How To Use

```
docker run -d --privileged \
    -e GCS_BUCKET_NAME=gpn-bucket \
    -v <KEY_FILE>:/etc/gcs/credential \
    -p 8080:80 \
    --name gcsfuse \
    gcsfuse
```

