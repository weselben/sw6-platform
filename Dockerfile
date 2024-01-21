FROM dockware/dev:6.5.8.0-amd64

USER root

RUN mkdir /var/www/html/custom-scripts/

# Copy the local entrypoint.sh file to the image
COPY ./custom-scripts/init-install.sh /var/www/html/custom-scripts/init-install.sh

# Set the correct permissions for the entrypoint.sh file
RUN chmod +x /var/www/html/custom-scripts/init-install.sh

# Expose ports 80 and 443
EXPOSE 80 443

USER dockware

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
