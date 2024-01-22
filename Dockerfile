FROM dockware/dev:6.5.8.0-amd64

USER root

RUN chown -R 33:33 /var/www/html/.

# Expose ports 80 and 443
EXPOSE 80 443

USER dockware

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
