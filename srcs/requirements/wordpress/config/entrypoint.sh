#!/bin/bash
set -e

export WP_ADMIN_PASSWORD="$(cat /run/secrets/wp_admin_password)"
export WP_USER_PASSWORD="$(cat /run/secrets/wp_user_password)"
export MARIADB_PASSWORD="$(cat /run/secrets/mariadb_password)"

config_file="/etc/php/8.2/fpm/pool.d/www.conf"
sed -ri 's|^;?\s*listen\s*=.*$|listen = 0.0.0.0:9000|' "$config_file"

for i in $(seq 1 30); do
    if (echo > /dev/tcp/${MARIADB_HOST}/${MARIADB_PORT}) >/dev/null 2>&1; then
        break
    fi
    sleep 1
done

if [ ! -e "${WP_PATH}/wp-includes/version.php" ]; then
    wp core download --allow-root --path="${WP_PATH}"
fi

if [ ! -f "${WP_PATH}/wp-config.php" ]; then
    wp config create \
        --allow-root \
        --path="${WP_PATH}" \
        --dbname="${MARIADB_DATABASE}" \
        --dbuser="${MARIADB_USER}" \
        --dbpass="${MARIADB_PASSWORD}" \
        --dbhost="${MARIADB_HOST}"
    wp core install \
        --allow-root \
        --path="${WP_PATH}" \
        --url="${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
            --skip-email
    if [ -n "${WP_USER}" ] && [ -n "${WP_USER_EMAIL}" ] && [ -n "${WP_USER_PASSWORD}" ]; then
        wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
            --user_pass="${WP_USER_PASSWORD}" \
            --role=author \
            --allow-root \
            --path="${WP_PATH}"
    fi
fi

chown -R www-data:www-data "${WP_PATH}"

exec php-fpm8.2 -F
