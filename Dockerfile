FROM mongo:4.0.0-xenial

RUN mkdir -p /scripts
RUN mkdir -p /backup

# Add Scripts
ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

CMD ["/start.sh"]