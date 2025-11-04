COMPOSE = docker compose -f srcs/docker-compose.yml -p inception
SERVICE ?=

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

rebuild:
	$(COMPOSE) build --no-cache $(SERVICE)
	$(COMPOSE) up -d $(SERVICE)

.PHONY: build up down clean ultra-full-clean rebuild