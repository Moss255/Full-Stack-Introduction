# Define variables
$CONTAINER_NAME = "mysql-container"
$MYSQL_ROOT_PASSWORD = "your-secure-password" # ⚠️  Change this to a strong password
$MYSQL_DATABASE = "my-database"
$MYSQL_USER = "my-user"
$MYSQL_PASSWORD = "my-user-password"

# Check if the container exists and stop/remove it to ensure a clean start
$container = docker ps -a -f "name=$CONTAINER_NAME"
if ($container) {
    Write-Host "Stopping and removing existing container: $CONTAINER_NAME"
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
}

# Run the MySQL container
Write-Host "Starting MySQL container: $CONTAINER_NAME"
docker run --name $CONTAINER_NAME `
-e "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" `
-e "MYSQL_DATABASE=$MYSQL_DATABASE" `
-e "MYSQL_USER=$MYSQL_USER" `
-e "MYSQL_PASSWORD=$MYSQL_PASSWORD" `
-p 3306:3306 `
-d mysql:latest

# Wait for the database to be ready
Write-Host "Waiting for MySQL to start..."
Start-Sleep -Seconds 10

# Display container status
docker ps -f "name=$CONTAINER_NAME"

Write-Host "MySQL container is running!"