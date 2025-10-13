#!/bin/sh
set -e

# init directory in which it has system tables
[ ! -d "/var/lib/mysql/mysql" ] && mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Configure root user
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'pass123';"

# Create database
mysql -e "CREATE DATABASE IF NOT EXISTS db;"

# Grant privileges to root user
mysql -e "GRANT ALL PRIVILEGES ON db.* TO 'root'@'localhost'; FLUSH PRIVILEGES;"

# Execute mariadb
exec runuser -u mysql -- mariadbd --console