# Remove config from proxy
ROOT_DIR=`pwd`

PROXY_DIR=${ROOT_DIR}/proxy
cd ${PROXY_DIR}
rm docker-compose.yml
echo "[Proxy] Remove docker-compose.yml success"

POSTGRES_DIR=${ROOT_DIR}/postgres
cd ${POSTGRES_DIR}
rm docker-compose.yml
echo "[DB] Remove docker-compose.yml success"

DJANGO_DIR=${ROOT_DIR}/django_project
cd ${DJANGO_DIR}
rm docker-compose.yml
echo "[Django] Remove docker-compose.yml success"

