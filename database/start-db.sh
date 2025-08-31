#!/bin/bash

# Define variables
CONTAINER_NAME="mysql-container"
MYSQL_ROOT_PASSWORD="your-secure-password" # ⚠️  Change this to a strong password
MYSQL_DATABASE="my-database"
MYSQL_USER="my-user"
MYSQL_PASSWORD="my-user-password"

# Check if the container already exists and stop/remove it to ensure a clean start
if [ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping and removing existing container: $CONTAINER_NAME"
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# Run the MySQL container
echo "Starting MySQL container: $CONTAINER_NAME"
docker run --name $CONTAINER_NAME \
-e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
-e MYSQL_DATABASE=$MYSQL_DATABASE \
-e MYSQL_USER=$MYSQL_USER \
-e MYSQL_PASSWORD=$MYSQL_PASSWORD \
-p 3306:3306 \
-d mysql:latest

# Wait for the database to be ready
echo "Waiting for MySQL to start..."
sleep 10

# Display container status
docker ps -f name=$CONTAINER_NAME

echo "MySQL container is running!"