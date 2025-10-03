# base image
FROM debian:bookworm

ARG MARIADB_CONFIG_FILE=/config/MARIADB_CONFIG_FILE

# define work dir to run commands in
WORKDIR .

# update packages and install mariadb
RUN apt update \
    apt upgrade -y \
    apt install -y mariadb-server

# expose port to receive connections
EXPOSE 3306

# copy config file to docker-entrypoint dir
COPY /config/entrypoint.sh ./docker-entrypoint-initdb.d/.

# start mariadb in foreground when container starts
ENTRYPOINT ["mariadbd", "--console"]