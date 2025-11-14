#!/bin/bash
set -e

export MARIADB_ROOT_PASSWORD="$(cat /run/secrets/mariadb_root_password)"
export MARIADB_PASSWORD="$(cat /run/secrets/mariadb_password)"

mkdir -p /var/lib/mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql /run/mysqld

cat <<EOF > /etc/mysql/init.sql
CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO '${MARIADB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
chown mysql:mysql /etc/mysql/init.sql


if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

# init mariadb
exec mysqld_safe --datadir=/var/lib/mysql \
    --bind-address=0.0.0.0 \
    --init-file=/etc/mysql/init.sql

