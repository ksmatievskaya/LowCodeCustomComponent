HASURA_GRAPHQL_METADATA_DATABASE_URL=postgres://superdba:postgrespassword@datacluster:5432/graphqlmetadata
HASURA_GRAPHQL_DEV_MODE=true

PGADMIN_DEFAULT_EMAIL=superdba@some.domain
PGADMIN_DEFAULT_PASSWORD=superdba

POSTGRES_PASSWORD=postgrespassword

AUTH_SMTP_HOST=smtpserver
AUTH_SMTP_PASS=smtpuser
AUTH_SMTP_USER=smtppassword
AUTH_SMTP_SECURE=false
AUTH_SMTP_SENDER=no-reply@some.domain

NC_DB="pg://datacluster:5432?u=superdba&p=postgrespassword&d=nocodb"
NC_PUBLIC_URL=http://tables.localhost
NC_DISABLE_TELE=true
NC_MIN=disable
NC_SMTP_FROM=no-reply@some.domain
NC_SMTP_HOST=smtpserver
NC_SMTP_PORT=1025
NC_SMTP_USERNAME=smtpuser
NC_SMTP_PASSWORD=smtppassword
