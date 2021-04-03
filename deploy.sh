# Update code
git pull origin master

# Build docker image
sudo docker build -t delivery --force-rm -f Dockerfile .

# Deploy image
sudo docker-compose stop
sudo docker-compose rm -f
sudo docker-compose up -d
sudo docker image prune --force
