# stop on error
# environment set
export PROJ_PATH=$(pwd)
## client path
export CLI_PATH=$PROJ_PATH/client
export CLI_BUILD_PATH=/usr/src/app/build
## container path
export NGINX_BUILD_PATH=$PROJ_PATH/nginx/nginx-dev

## server path
export SER_PATH=$PROJ_PATH/server
export SER_BUILD_PATH=/usr/src/app/dist
## container path
export PM2_BUILD_PATH=$PROJ_PATH/pm2

CD $PROJ_PATH
docker-compose -f docker-compose.dev.yml down

# run for client
echo "\033[0;32m# run for client"  
## build client image & run 
echo "## build client image & run\033[0;0m" 
cd $CLI_PATH
docker build -t client -f Dockerfile.prod .
docker run -dit --name client client 
## pass build result to host volumes 
echo "\033[0;32m## pass build result to host volumes\033[0;0m"
cd $PROJ_PATH
docker cp client:$CLI_BUILD_PATH $NGINX_BUILD_PATH
docker rm -f client

# run for server
echo "\033[0;32m# run for server" 
## build server 
echo "## build server\033[0;0m"
cd $SER_PATH
docker build -t server -f Dockerfile.prod .
docker run -dit --name server server
## pass build result to host volumes
echo "## pass build result to host volumes"
cd $PROJ_PATH
docker cp server:$SER_BUILD_PATH $PM2_BUILD_PATH
docker rm -f server

cd $PROJ_PATH
docker-compose -f docker-compose.dev.yml up

# npm i
# npm run build
# cd ../server
# npm i
# npm run build
# cd ../docker
# mv -f nginx-prod/* nginx/nginx
# docker exec docker_pm2_1 pm2 reload /dist/app.js
# docker exec docker_nginx_1 service nginx reload