FROM alpine:edge

LABEL maintainer="Rifky Ekayama <rifky.ekayama@gmail.com>"
 
RUN apk update \
  && apk add \
         dcron \
         bash \
         curl \
         wget \
         rsync \
         ca-certificates \
         zip \
         mongodb-tools \
  && rm -rf /var/cache/apk/*

RUN mkdir -p /var/log/cron \
  && mkdir -m 0644 -p /var/spool/cron/crontabs \
  && touch /var/log/cron/cron.log \
  && mkdir -m 0644 -p /etc/cron.d

COPY /scripts/* /

# RUN mkdir -p /scripts
# RUN mkdir -p /backups

ENTRYPOINT ["/docker-entry.sh"]
CMD ["/docker-cmd.sh"]