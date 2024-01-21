#!/bin/sh

FILE=installed.lock
if [ -f "$FILE" ]; then
    echo "Already installed! Script will delete all Files, at rerunn it will reinstall Shopware"
    find /var/www/html/ -mindepth 1 -maxdepth 1 ! -path '/var/www/html/custom-scripts/*' ! -name 'init-install.sh' -exec rm -rf {} \;
else
    echo "Waiting 8 seconds for the Database Container"
    sleep 8s

    php bin/console assets:install
    php bin/console system:install --force
    php	bin/console system:generate-jwt-secret --force

    # Use SHOP_DOMAIN environment variable for storefront creation
    if [ -n "$SHOP_DOMAIN" ]; then
        php bin/console sales-channel:create:storefront --url="http://$SHOP_DOMAIN"
        #php bin/console sales-channel:create:storefront --url="https://$SHOP_DOMAIN"
    else
        echo "Error: SHOP_DOMAIN environment variable not set."
        exit 1
    fi

    #php bin/console sales-channel:create:storefront --url=http://localhost

    # Use environment variables for admin credentials
    if [ -n "$INSTALL_ADMIN_USERNAME" ] && [ -n "$INSTALL_ADMIN_PASSWORD" ]; then
        php bin/console user:create -a -p "$INSTALL_ADMIN_PASSWORD" "$INSTALL_ADMIN_USERNAME"
    else
        echo "Error: INSTALL_ADMIN_USERNAME or INSTALL_ADMIN_PASSWORD environment variables not set."
        exit 1
    fi

    touch installed.lock
    exit
fi
