#!/bin/bash
LETS_ENCRYPT_TEST_RUN=0
#USE_POSTGRES=false

CONTAINER_PREFIX='1'
DJANGO_PROJECT_NAME='telegram_bot'
POSTGRE_SQL_PASSWORD='postgres_password'
HOST_NAME='YOUR.DOMAIN.HERE'
MAINTAINER='YOUR@EMAIL.HERE'

if [ -z ${DJANGO_PROJECT_NAME+x} ]; then 
    echo "DJANGO_PROJECT_NAME is unset"; 
    exit -1
fi

if [ -z ${POSTGRE_SQL_PASSWORD+x} ]; then 
    echo "POSTGRE_SQL_PASSWORD is unset"; 
    exit -2
fi

if [ -z ${HOST_NAME+x} ]; then 
    echo "HOST_NAME is unset"; 
    exit -3
fi

if [ -z ${MAINTAINER+x} ]; then 
    echo "MAINTAINER is unset"; 
    exit -4
fi

