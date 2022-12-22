prepare:
	docker compose --env-file .env.dev pull
configure:

build:

dumpdata:

publish:

deploy:
	docker compose --env-file .env.dev up -d

production:
	docker compose up --env-file .env.prod -d
