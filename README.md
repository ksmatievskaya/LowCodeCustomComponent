# Предметная область как сервис

ключевые принципы 

* "только владелец процесса знает - какой процесс он хочет выстроить и какими данными он будет оперировать"
* "

## Использование

* установить Linux или WSL2 c установленной утилитой make и подсистемой Docker
* выполните команду `make prepare`
* выполните команду `make configure`
* выполните команду `make deploy`

## Локальная первичная настройка

* системный администратор - http://localhost:81
    * зайдите под именем `admin@example.com` и паролем `changeme` для изменения пароля
    * добавьте прокси доменного имени `proxy.localhost` указывающего внутрь docker сети на DNS имя `proxy` и порт `81`
    * зайдите по адресу http://proxy.localhost/nginx/proxy чтобы проверить как работает прокси-сервер
    * добавьте прокси доменного имени `dba.localhost` указывающего внутрь docker сети на DNS имя `dba-admin` и порт `80`
    * добавьте прокси доменного имени `api.localhost` указывающего внутрь docker сети на DNS имя `graphql-mesh` и порт `8080`
    * добавьте прокси доменного имени `tables.localhost` указывающего внутрь docker сети на DNS имя `nocodedb` и порт `8080`
    * добавьте прокси доменного имени `workflow.localhost` указывающего внутрь docker сети на DNS имя `workflow` и порт `5678`
    * добавьте прокси доменного имени `apps.localhost` указывающего внутрь docker сети на DNS имя `appslowcode` и порт `5678`
    * добавьте прокси доменного имени `bi.localhost` указывающего внутрь docker сети на DNS имя `biservice` и порт `3000`
* зайдите по адресу http://dba.localhost/browser/
    * введите `superdba@iczin.guru` и `superdba`
    * добавьте сервер с DNS адресом `datacluster` с пользователем `superdba@iczin.guru` и паролем `postgrespassword`
* зайдите по адресу http://api.localhost/console/data/manage для проверки доступности API
* зайдите по адресу http://bi.localhost/ - 
* зайдите по адресу http://tables.localhost - 
* зайдите по адресу http://workflow.localhost/workflows -
* зайдите по адресу http://apps.localhost - 
 
## Технологический состав

* Nginx Proxy Manager
* Hasura
* PostgreSQL 15.x
* n8n worflow
* nocodb
* tooljet
* metabase

