# build container
docker build -f images/mem-gpt/Dockerfile -t memgpt .

# run container
# docker run -d --rm \
#    --name memgpt-db-test \
#    -p 8283:8283 \
#    -e OPENAI_API_KEY=key \
#    -v data/memgpt:/some/home/folder/.memgpt \
#     memgpt:latest