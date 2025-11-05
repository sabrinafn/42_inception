# base image
FROM debian:bookworm

# update packages and install nginx
RUN apt update \
    && apt upgrade -y \
    && apt install -y nginx

COPY config/default.conf /etc/nginx/sites-available/.
COPY certificates/sabrifer.42.fr.crt /etc/ssl/certs/
COPY certificates/sabrifer.42.fr.key /etc/ssl/private/

CMD ["nginx", "-g", "daemon off;"]