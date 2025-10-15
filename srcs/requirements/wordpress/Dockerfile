# base image
FROM debian:bookworm

# update packages and install nginx
RUN apt update \
    && apt upgrade -y \
    && apt install -y php-fpm php-mysqli curl

COPY www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY config/init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/init.sh"]