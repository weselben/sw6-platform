FROM dockware/dev:6.5.8.2-amd64

USER dockware

COPY entrypoint.sh /entrypoint.sh

# Expose ports 80 and 443
EXPOSE 80 443

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
