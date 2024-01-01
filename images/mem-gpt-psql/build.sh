# build container
docker build -f images/mem-gpt-psql/Dockerfile -t pg-test .

# run container
# docker run -d --rm \
#    --name memgpt-db-test \
#    -p 8888:5432 \
#    -e POSTGRES_PASSWORD=password \
#    -v memgpt_db_test:/var/lib/postgresql/data \
#     pg-test:latest