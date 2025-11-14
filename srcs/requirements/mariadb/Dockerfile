FROM debian:bookworm

RUN apt update \
    && apt upgrade -y \
    && apt install -y mariadb-server

COPY config/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN mkdir /run/mysqld \
    && chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

CMD ["/usr/local/bin/entrypoint.sh"]