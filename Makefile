prepare:
	docker compose --env-file .env.dev pull

configure: prepare
	docker compose --env-file .env.dev up datacluster -d
	bash 02-loaddata.sh
	docker compose --env-file .env.dev up dba-admin -d

build:
	docker compose build

dumpdata:
	bash 10-dumpdata.sh

publish: configure
	docker compose --env-file .env.dev up proxy -d

deploy: publish
	export UID=$(id -u) && export GID=$(id -g) && docker compose --env-file .env.dev up -d

production:
	docker compose up --env-file .env.prod -d

clean:
	export UID=$(id -u) && export GID=$(id -g) && docker compose --env-file .env.dev down

dockerfull-prune:
	docker system prune -a --volumes 

