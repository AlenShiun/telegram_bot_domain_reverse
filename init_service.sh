#!/bin/bash
source ./config.sh

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo 'System OS: Linux'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo 'System OS: MAC OSX'
fi

DJANGO_PROJECT_NAME_WITHOUT_UNDERLINE=${DJANGO_PROJECT_NAME//_/-}

# ==================================================
# Generate docker-compose for DB - start
# ==================================================
POSTGRES_DIR="`pwd`/postgres"
echo "[DB] Generate docker-compose for postgres..."
sed "s/POSTGRES_PASSWORD\=\S*/POSTGRES_PASSWORD=${POSTGRE_SQL_PASSWORD}/g" ${POSTGRES_DIR}/docker-compose.yml.example > ${POSTGRES_DIR}/docker-compose.yml
echo "[DB] Set PostgreSQL password success"

# Use name of django project as prefix of volume name
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sed -i "s/pgdata/${DJANGO_PROJECT_NAME}-pgdata/g" ${POSTGRES_DIR}/docker-compose.yml
elif [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/pgdata/${DJANGO_PROJECT_NAME}-pgdata/g" ${POSTGRES_DIR}/docker-compose.yml
fi

echo "[DB] Generate docker-compose for postgres success"

# ==================================================
# Generate docker-compose for DB - finish
# ==================================================

# ==================================================
# Generate docker files for Django project - start
# ==================================================
DJANGO_PROJECT_DIR_NAME="django_project"
DJANGO_PROJECT_DIR="`pwd`/${DJANGO_PROJECT_DIR_NAME}"
echo "[Django] Generate docker-compose for django project..."

# Copy docker-compose example and set container name of nginx
sed "s/nginx-container/${CONTAINER_PREFIX}-${DJANGO_PROJECT_NAME_WITHOUT_UNDERLINE}-nginx-container/g" ${DJANGO_PROJECT_DIR}/docker-compose.yml.example > ${DJANGO_PROJECT_DIR}/docker-compose.yml

# Set container name of django project 
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sed -i "s/web-container/${CONTAINER_PREFIX}-${DJANGO_PROJECT_NAME_WITHOUT_UNDERLINE}-web-container/g" ${DJANGO_PROJECT_DIR}/docker-compose.yml
elif [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/web-container/${CONTAINER_PREFIX}-${DJANGO_PROJECT_NAME_WITHOUT_UNDERLINE}-web-container/g" ${DJANGO_PROJECT_DIR}/docker-compose.yml
fi
echo "[Django] Set container name success"

# Copy neccesary configs from eample of docker and django files such as Dockerfile, docker-entrypoint and uwsgi, ...etc.
cp -rn ${DJANGO_PROJECT_DIR}/docker_example/* ${DJANGO_PROJECT_DIR}/${DJANGO_PROJECT_NAME}/
chmod +x ${DJANGO_PROJECT_DIR}/${DJANGO_PROJECT_NAME}/docker-entrypoint.sh

# Set up run time name of container, volume and HOST name
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Volume name
    sed -i "s+project_data+./${DJANGO_PROJECT_NAME}+g" ${DJANGO_PROJECT_DIR}/docker-compose.yml

    # Setup variables of for django build
    sed -i "s+build:\ web_project+build:\ ./${DJANGO_PROJECT_NAME}+g" ${DJANGO_PROJECT_DIR}/docker-compose.yml

    # Setup variables according to project name of django
    sed -i "s/web_project/${CONTAINER_PREFIX}_${DJANGO_PROJECT_NAME}/g" ${DJANGO_PROJECT_DIR}/docker-compose.yml
    sed -i "s/web_project/${DJANGO_PROJECT_NAME}/g" ${DJANGO_PROJECT_DIR}/${DJANGO_PROJECT_NAME}/uwsgi.ini

    # Setup variables of HOST
    sed -i "s/VIRTUAL_HOST\=\S*/VIRTUAL_HOST=${HOST_NAME}/g" ${DJANGO_PROJECT_DIR}/docker-compose.yml
    sed -i "s/LETSENCRYPT_HOST\=\S*/LETSENCRYPT_HOST=${HOST_NAME}/g" ${DJANGO_PROJECT_DIR}/docker-compose.yml

    # Setup maintainer
    sed -i "s/LETSENCRYPT_EMAIL\=\S*/LETSENCRYPT_EMAIL=${MAINTAINER}/g" ${DJANGO_PROJECT_DIR}/docker-compose.yml
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Volume name
    sed -i '' "s+project_data+./${DJANGO_PROJECT_NAME}+g" ${DJANGO_PROJECT_DIR}/docker-compose.yml

    # Setup variables of for django build
    sed -i '' "s+build:\ web_project+build:\ ./${DJANGO_PROJECT_NAME}+g" ${DJANGO_PROJECT_DIR}/docker-compose.yml

    # Setup variables according to project name of django
    sed -i '' "s/web_project/${CONTAINER_PREFIX}_${DJANGO_PROJECT_NAME}/g" ${DJANGO_PROJECT_DIR}/docker-compose.yml
    sed -i '' "s/web_project/${DJANGO_PROJECT_NAME}/g" ${DJANGO_PROJECT_DIR}/${DJANGO_PROJECT_NAME}/uwsgi.ini

    # Setup variables of HOST
    sed -i '' "s/VIRTUAL_HOST\=\S*/VIRTUAL_HOST=${HOST_NAME}/g" ${DJANGO_PROJECT_DIR}/docker-compose.yml
    sed -i '' "s/LETSENCRYPT_HOST\=\S*/LETSENCRYPT_HOST=${HOST_NAME}/g" ${DJANGO_PROJECT_DIR}/docker-compose.yml

    # Setup maintainer
    sed -i '' "s/LETSENCRYPT_EMAIL\=\S*/LETSENCRYPT_EMAIL=${MAINTAINER}/g" ${DJANGO_PROJECT_DIR}/docker-compose.yml
fi
echo "[Django] Set volume name success"
echo "[Django] Generate docker-compose for django project success"

# ==================================================
# Generate docker files for Django project - finish
# ==================================================

