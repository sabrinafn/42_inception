# base image
FROM debian:bookworm

# update packages and install mariadb
RUN apt update \
    && apt upgrade -y \
    && apt install -y mariadb-server

COPY config/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN mkdir /run/mysqld \
    && chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

# run as non-root user
CMD ["/usr/local/bin/entrypoint.sh"]