# base image
FROM debian:bookworm

# update packages and install nginx
RUN apt update \
    && apt upgrade -y \
    && apt install -y nginx

COPY default /etc/nginx/sites-available/.

CMD ["nginx", "-g", "daemon off;"]