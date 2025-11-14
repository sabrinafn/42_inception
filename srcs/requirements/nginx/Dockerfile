FROM debian:bookworm

RUN apt update \
    && apt upgrade -y \
    && apt install -y nginx

COPY config/default.conf /etc/nginx/sites-enabled/default.conf
COPY certificates/sabrifer.42.fr.crt /etc/ssl/certs/sabrifer.42.fr.crt
COPY certificates/sabrifer.42.fr.key /etc/ssl/private/sabrifer.42.fr.key

RUN rm -f /etc/nginx/sites-enabled/default

CMD ["nginx", "-g", "daemon off;"]