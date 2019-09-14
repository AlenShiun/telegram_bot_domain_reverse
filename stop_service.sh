#!/bin/bash

ROOT_DIR=`pwd`

cd ${ROOT_DIR}/django_project
docker-compose down

cd ${ROOT_DIR}/postgres
docker-compose down

