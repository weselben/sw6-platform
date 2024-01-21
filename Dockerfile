FROM dockware/dev:6.5.8.0-amd64

USER root

RUN mkdir /var/www/html/custom-scripts/

# Copy the local entrypoint.sh file to the image
COPY ./custom-scripts/init-install.sh /var/www/html/custom-scripts/init-install.sh

# Set the correct permissions for the entrypoint.sh file
RUN chmod +x /var/www/html/custom-scripts/init-install.sh

#Custom Shopware Settings

RUN echo -e "shopware:\n  increment:\n    user_activity:\n      type: 'redis'\n      config:\n        url: 'redis://$REDIS_SESSION_HOST:$REDIS_SESSION_PORT/0'\n    message_queue:\n      type: 'redis'\n      config:\n        url: 'redis://$REDIS_SESSION_HOST:$REDIS_SESSION_PORT/0'" > /var/www/html/config/packages/prod/shopware.yaml

RUN echo -e "framework:\n  lock: 'redis://$REDIS_SESSION_HOST:$REDIS_SESSION_PORT'" > /var/www/html/config/packages/prod/framework.yaml

RUN echo -e "shopware:\n  number_range:\n    increment_storage: 'Redis'\n    redis_url: 'redis://$REDIS_SESSION_HOST:$REDIS_SESSION_PORT/0'" > /var/www/html/config/packages/prod/shopware.yaml


# Expose ports 80 and 443
EXPOSE 80 443

USER dockware

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
