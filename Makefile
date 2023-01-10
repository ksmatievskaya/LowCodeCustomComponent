prepare:
	docker compose --env-file .env.settings pull

configure: prepare
	docker compose --env-file .env.settings up datacluster -d
	bash 02-loaddata.sh
	docker compose --env-file .env.settings up dba-admin -d

build:
	docker compose build

publish: configure
	docker compose --env-file .env.settings up proxy -d

deploy: publish
	bash scripts/03-create-proxy-domains.sh
	export UID=$(id -u) && export GID=$(id -g) && docker compose --env-file .env.settings up -d

production:
	docker compose up --env-file .env.prod -d

clean:
	export UID=$(id -u) && export GID=$(id -g) && docker compose --env-file .env.settings down

dockerfull-prune:
	docker system prune -a --volumes 

dumpdata:
	bash 10-dumpdata.sh

topology:
	bash 99-generate-topology.sh
