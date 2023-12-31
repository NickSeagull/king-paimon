# syntax = docker/dockerfile:1.6

# Build a self-configuring postgres image with pgvector installed.
# It has no dependencies except for the base image.

# Build with:
# docker build -t memgpt-db -f db/Dockerfile.simple .
#
# -t memgpt-db: tag the image with the name memgpt-db (tag defaults to :latest)
# -f db/Dockerfile.simple: use the Dockerfile at db/Dockerfile.simple (this file)
# .: build the image from the current directory, not really used.

#
# Run the first time with:
# docker run -d --rm \
#   --name memgpt-db \
#   -p 5432:5432 \
#   -e POSTGRES_PASSWORD=password \
#   -v memgpt_db:/var/lib/postgresql/data \
#   memgpt-db:latest
#
# -d: run in the background
# --rm: remove the container when it exits
# --name memgpt-db: name the container memgpt-db
# -p 5432:5432: map port 5432 on the host to port 5432 in the container
# -v memgpt_db:/var/lib/postgresql/data: map the volume memgpt_db to /var/lib/postgresql/data in the container
# memgpt-db:latest: use the image memgpt-db:latest
#
# After the first time, you do not need the POSTGRES_PASSWORD.
# docker run -d --rm \
#   --name memgpt-db \
#   -p 5432:5432 \
#   -v memgpt_db:/var/lib/postgresql/data \
#   memgpt-db:latest

# Rather than a docker volume (memgpt_db), you can use an absolute path to a directory on the host.
#
# You can stop the container with:
#  docker stop memgpt-db
#
# You access the database with:
# postgresql+pg8000://user:password@localhost:5432/db
# where user, password, and db are the values you set in the init-memgpt.sql file,
# all defaulting to 'memgpt'.

# Version tags can be found here: https://hub.docker.com/r/ankane/pgvector/tags
ARG PGVECTOR=v0.5.1
# Set up a minimal postgres image
FROM ankane/pgvector:${PGVECTOR}
RUN sed -e 's/^    //' >/docker-entrypoint-initdb.d/01-initmemgpt.sql <<'EOF'
    -- Title: Init MemGPT Database

    -- Fetch the docker secrets, if they are available.
    -- Otherwise fall back to environment variables, or hardwired 'memgpt'
    \set db_user `([ -r /var/run/secrets/memgpt-user ] && cat /var/run/secrets/memgpt-user) || echo "${MEMGPT_USER:-memgpt}"`
    \set db_password `([ -r /var/run/secrets/memgpt-password ] && cat /var/run/secrets/memgpt-password) || echo "${MEMGPT_PASSWORD:-memgpt}"`
    \set db_name `([ -r /var/run/secrets/memgpt-db ] && cat /var/run/secrets/memgpt-db) || echo "${MEMGPT_DB:-memgpt}"`

    CREATE USER :"db_user"
        WITH PASSWORD :'db_password'
        NOCREATEDB
        NOCREATEROLE
        ;

    CREATE DATABASE :"db_name"
        WITH
        OWNER = :"db_user"
        ENCODING = 'UTF8'
        LC_COLLATE = 'en_US.utf8'
        LC_CTYPE = 'en_US.utf8'
        LOCALE_PROVIDER = 'libc'
        TABLESPACE = pg_default
        CONNECTION LIMIT = -1;

    -- Set up our schema and extensions in our new database.
    \c :"db_name"

    CREATE SCHEMA :"db_name"
        AUTHORIZATION :"db_user";

    ALTER DATABASE :"db_name"
        SET search_path TO :"db_name";

    CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA :"db_name";

    DROP SCHEMA IF EXISTS public CASCADE;
EOF