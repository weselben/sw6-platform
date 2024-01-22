FROM dockware/dev:6.5.8.0-amd64

USER root

RUN chown 33:33 -R /var/www/html/.

# Expose ports 80 and 443
EXPOSE 80 443

USER dockware

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
