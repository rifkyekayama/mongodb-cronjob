FROM mongo:4.0.0-xenial

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install \
      cron \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /scripts
RUN mkdir -p /backup

# Add Scripts
ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

CMD ["/start.sh"]