prepare:
	docker compose --env-file .env.dev pull
configure:
	
build:
	docker compose build
dumpdata:
	
publish:

deploy:
	docker compose --env-file .env.dev up -d

production:
	docker compose up --env-file .env.prod -d

dockerfull-prune:
	docker system prune -a --volumes 

