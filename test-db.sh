#!/bin/bash
docker run --name springbootcrudapp-db -p 3306:3306 -e MYSQL_RANDOM_ROOT_PASSWORD=yes -e MYSQL_DATABASE -e MYSQL_USER -e MYSQL_PASSWORD -d mysql:8.0
sed -i '2s/db/localhost/2' src/main/resources/application.properties
sleep 3
mvn test
sed -i '2s/localhost/db/' src/main/resources/application.properties
docker rm -f springbootcrudapp-db