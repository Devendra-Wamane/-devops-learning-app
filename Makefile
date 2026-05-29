# ── Makefile: shortcuts for common DevOps commands ───────────────────────────
# Run any target with: make <target>
# Example: make build

.PHONY: help build up down logs test clean shell

help:
	@echo ""
	@echo "  DevOps Learning App - Available Commands"
	@echo "  ─────────────────────────────────────────"
	@echo "  make build    - Build the Docker image"
	@echo "  make up       - Start all containers (app + nginx)"
	@echo "  make down     - Stop and remove containers"
	@echo "  make logs     - Follow container logs"
	@echo "  make test     - Run unit tests"
	@echo "  make shell    - Open a shell inside the app container"
	@echo "  make clean    - Remove containers, images, and volumes"
	@echo "  make health   - Check app health endpoint"
	@echo ""

build:
	docker compose build

up:
	docker compose up -d
	@echo "App running at http://localhost (via nginx)"
	@echo "Direct app at http://localhost:5000"

down:
	docker compose down

logs:
	docker compose logs -f

test:
	pip install pytest
	cd app && pytest tests/ -v

shell:
	docker exec -it taskapp /bin/sh

clean:
	docker compose down -v --rmi local

health:
	curl -s http://localhost:5000/health | python -m json.tool
