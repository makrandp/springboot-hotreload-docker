# Java Spring boot app using docker with hot reload

## Setup
- `docker-compose up --force-recreate`
- In Eclipse:
  - Run Configurations -> Java Application -> New
  - Choose `org.springframework.boot.devtools.RemoteSpringApplication` as the `main class`
  - Choose `hotreload` as the project
  - Set http://localhost:8080 to program arguments

## Useful Commands
- `docker-compose up --force-recreate -d`
- `docker-compose start`
- `docker-compose stop`
- `docker-compose down --rmi all`