# base image
FROM debian:bookworm

# define work dir to run commands in
WORKDIR .

# update packages and install mariadb
RUN apt update \
    && apt upgrade -y \
    && apt install -y mariadb-server \
    && apt install -y mariadb-client

# expose port to receive connections
EXPOSE 3306

# copy config file to docker-entrypoint dir
COPY /config/entrypoint.sh /script/

RUN chmod +x /script/entrypoint.sh

# start mariadb in foreground when container starts
ENTRYPOINT ["/script/entrypoint.sh"]