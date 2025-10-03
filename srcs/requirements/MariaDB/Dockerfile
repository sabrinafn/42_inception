# base image
FROM debian:bookworm

# define work dir to run commands in
WORKDIR .

# update packages and install mariadb
RUN sudo apt update && sudo apt upgrade \
    sudo apt install mariadb-server -y

# expose port to receive connections
EXPOSE 3306:3306

# copy config dir to docker-entrypoint dir
COPY /config ./docker-entrypoint-initdb.d/


ARG MARIADB_CONFIG_FILE=/config/MARIADB_CONFIG_FILE


# start container with this file config
ENTRYPOINT mariadbd --defaults-file=$MARIADB_CONFIG_FILE

# command to start the server
CMD ["mariadbd"]