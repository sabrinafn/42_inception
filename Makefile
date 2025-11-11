COMPOSE = docker compose -f srcs/docker-compose.yml -p inception
SERVICE ?=

all: prepare-dirs build up

prepare-dirs:
	@sudo mkdir -p /home/sabrifer/data/mysql /home/sabrifer/data/wordpress
	@sudo chown -R $$(id -u):$$(id -g) /home/sabrifer/data

build:
	$(COMPOSE) build $(SERVICE)    

up:
	$(COMPOSE) up -d $(SERVICE)

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v --rmi local --remove-orphans

ultra-full-clean: clean
	docker builder prune -af
	docker system prune -af --volumes

rebuild: prepare-dirs
	$(COMPOSE) build --no-cache $(SERVICE)
	$(COMPOSE) up -d $(SERVICE)

.PHONY: prepare-dirs build up down clean ultra-full-clean rebuild