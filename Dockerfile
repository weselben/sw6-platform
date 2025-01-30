FROM dockware/dev:6.6.9.0-amd64

USER dockware

COPY entrypoint.sh /entrypoint.sh

# Expose ports 80 and 443
EXPOSE 80 443

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
