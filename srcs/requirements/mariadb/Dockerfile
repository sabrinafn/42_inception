# base image
FROM debian:bookworm

# update packages and install mariadb
RUN apt update \
    && apt upgrade -y \
    && apt install -y mariadb-server

# run as non-root user
CMD ["mysqld_safe"]