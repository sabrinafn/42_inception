COMPOSE = docker compose -f srcs/docker-compose.yml -p inception
SERVICE ?=
PROJECT_ENV_URL = https://raw.githubusercontent.com/sabrinafn/42_inception/refs/heads/main/

all: prepare-files build up

prepare-files:
	@sudo mkdir -p /home/sabrifer/data/mysql /home/sabrifer/data/wordpress
	@sudo chown -R $$(id -u):$$(id -g) /home/sabrifer/data

	@if [ ! -f ./srcs/.env ]; then \
		curl -fsSL "$(PROJECT_ENV_URL)/srcs/.env" -o ./srcs/.env; \
	fi
	@if [ ! -d ./secrets ]; then \
		mkdir ./secrets; \
		curl -fsSL "$(PROJECT_ENV_URL)/secrets/db_password.txt" -o ./secrets/db_password.txt; \
		curl -fsSL "$(PROJECT_ENV_URL)/secrets/db_root_password.txt" -o ./secrets/db_root_password.txt; \
		curl -fsSL "$(PROJECT_ENV_URL)/secrets/wp_admin_password.txt" -o ./secrets/wp_admin_password.txt; \
		curl -fsSL "$(PROJECT_ENV_URL)/secrets/wp_user_password.txt" -o ./secrets/wp_user_password.txt; \
	fi
	@if [ ! -d ./srcs/requirements/nginx/certificates ]; then \
		mkdir -p ./srcs/requirements/nginx/certificates; \
		curl -fsSL "$(PROJECT_ENV_URL)/srcs/requirements/nginx/certificates/sabrifer.42.fr.crt" -o ./srcs/requirements/nginx/certificates/sabrifer.42.fr.crt; \
		curl -fsSL "$(PROJECT_ENV_URL)/srcs/requirements/nginx/certificates/sabrifer.42.fr.key" -o ./srcs/requirements/nginx/certificates/sabrifer.42.fr.key; \
	fi

build:
	$(COMPOSE) build $(SERVICE)    

up:
	$(COMPOSE) up -d $(SERVICE)

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v

fclean: clean
	docker builder prune -af
	docker system prune -af --volumes

re: fclean prepare-files
	$(COMPOSE) build --no-cache $(SERVICE)
	$(COMPOSE) up -d $(SERVICE)

.PHONY: prepare-files build up down clean fclean re