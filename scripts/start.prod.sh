# environment set
export PROJ_PATH=$(pwd)
## client path
export CLI_PATH=$PROJ_PATH/client
export CLI_BUILD_PATH=/usr/src/app/build
## server path
export SER_PATH=$PROJ_PATH/server
export SER_BUILD_PATH=/usr/src/app/build
## container path
export NGINX_BUILD_PATH=$PROJ_PATH/nginx/build
export PM2_BUILD_PATH=$PROJ_PATH/node/dist

# run for client
## build client image & run 
cd $CLI_PATH
docker build -t client -f Dockerfile.prod .
docker run -dit --name client client 
## pass build result to host volumes 
cd $PROJ_PATH
docker cp client:$CLI_BUILD_PATH $NGINX_BUILD_PATH

# run for server
## build server 
cd $SER_PATH
docker build -t server -f Dockerfile.prod .
docer run -dit --name server server
## pass build result to host volumes
cd $PROJ_PATH
docker cp client:$SER_BUILD_PATH $PM2_BUILD_PATH



# npm i
# npm run build
# cd ../server
# npm i
# npm run build
# cd ../docker
# mv -f nginx-prod/* nginx/nginx
# docker exec docker_pm2_1 pm2 reload /dist/app.js
# docker exec docker_nginx_1 service nginx reload