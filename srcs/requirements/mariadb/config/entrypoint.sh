#!/bin/sh

mysql_install_db
mysqld

while ! mysqladmin ping -h localhost --silent; do
    sleep 1
done

exec init.sql