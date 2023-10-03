FROM docker.io/library/alpine:3.18

COPY filldisk.sh /filldisk.sh

# START_SIZE and INCREMENT are in MiB.
# MAX_ITER is multiplied by INCREMENT.
ENV \
    START_SIZE=2048 \
    MAX_ITER=4 \
    INCREMENT=1024 \
    TEMP_FILE=""

ENTRYPOINT ["/bin/ash", "/filldisk.sh"]
