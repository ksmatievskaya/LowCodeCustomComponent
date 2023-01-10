# Примеры настроек

правила наименования файлов `env.<окружение>.<имя-сервиса>`

## Настройки окружения BI

> сервис для разработки панелей контроля ключевых результатов, пока базируется на Metabase https://www.metabase.com/docs/latest/configuring-metabase/setting-up-metabase

* тип субд для хранения метаданных, пример `MB_DB_TYPE=postgres`
* имя СУБД для хранения метаданных, пример `MB_DB_DBNAME=okrdb`
* порт СУБД для хранения метаданных, пример `MB_DB_PORT=5432`
* пользователь СУБД с доступом на исполнение транзакци, пример `MB_DB_USER=superdba`
* пароль пользователя СУБД, пример `MB_DB_PASS=postgrespassword`
* DNS имя или IP местонахождения сервера СУБД `MB_DB_HOST=datacluster`

## Настройки окружения GraphQL

> сервис для построения графовых запросов с фронтенда на бекенд в условиях когда имеется множество REST API и множество СУБД, пока бащируется на Hasura https://hasura.io/docs/latest/databases/index/

* строка подключения к базе хранения метаданных сервиса, пример `HASURA_GRAPHQL_METADATA_DATABASE_URL=postgres://superdba:postgrespassword@datacluster:5432/graphqlmetadata`
* включение разработческого режима развертывания сервиса, пример `HASURA_GRAPHQL_DEV_MODE=true`
* включение интерактивной консоли для отладки запросов, пример `HASURA_GRAPHQL_ENABLE_CONSOLE=true`
* список активированных журналов `HASURA_GRAPHQL_ENABLED_LOG_TYPES="startup, http-log, webhook-log, websocket-log, query-log"`

> TODO - продожить документирование
