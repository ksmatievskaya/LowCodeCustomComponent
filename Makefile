prepare:
	docker compose --env-file .env.dev pull

configure:
	docker compose --env-file .env.dev up datacluster -d
	bash 02-loaddata.sh

build:
	docker compose build

dumpdata:
	./10-dumpdata.sh
		
publish:

deploy:
	export UID=$(id -u) && export GID=$(id -g) && docker compose --env-file .env.dev up -d

production:
	docker compose up --env-file .env.prod -d

clean:
	export UID=$(id -u) && export GID=$(id -g) && docker compose --env-file .env.dev down

dockerfull-prune:
	docker system prune -a --volumes 

