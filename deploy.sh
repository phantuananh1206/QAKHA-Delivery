# Update code
git pull origin master

# Build docker image
docker build -t delivery --force-rm -f Dockerfile .

# Deploy image
docker-compose stop
docker-compose rm -f
docker-compose up -d