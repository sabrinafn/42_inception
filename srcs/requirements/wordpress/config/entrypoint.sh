#!/bin/bash
set -e

WP_PATH=/var/www/html

until mysqladmin ping -h"$MARIADB_HOST" --silent; do
    sleep 1
done

# if !wp-config.php, create and install WordPress
if [ ! -f $WP_PATH/wp-config.php ]; then
    wp config create \
        --allow-root \
        --path=$WP_PATH \
        --dbname=$MARIADB_DATABASE \
        --dbuser=$MARIADB_USER \
        --dbpass=$MARIADB_PASSWORD \
        --dbhost=$MARIADB_HOST

    wp core install \
        --allow-root \
        --path=$WP_PATH \
        --url="${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}"

    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role=author \
        --allow-root \
        --path=$WP_PATH
fi

chown -R www-data:www-data $WP_PATH

exec php-fpm7.4 -F
