#!/bin/bash
docker build -t melvincv/mysql-maven:8.0-mvn3.8.6 .
docker login
docker push melvincv/mysql-maven:8.0-mvn3.8.6