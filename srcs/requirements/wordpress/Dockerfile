# base image
FROM debian:bookworm

# update packages and install nginx
RUN apt update \
    && apt upgrade -y \
    && apt install -y php-fpm php-mysqli curl

# install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY config/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY config/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]