#!/bin/bash
source ./config.sh

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo 'System OS: Linux'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo 'System OS: MAC OSX'
fi

# Generate docker-compose for nginx-proxy
PROXY_DIR="`pwd`/proxy"
echo "[Proxy] Generate docker-compose for proxy..."
cp ${PROXY_DIR}/docker-compose.yml.example ${PROXY_DIR}/docker-compose.yml
echo "[Proxy] Create docker-compose ok "

# Comment out Let's encrypt test server if needed
if [[ ${LETS_ENCRYPT_TEST_RUN} != 1 ]]; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        sed -e '/ACME_CA_URI/ s/^#*/#/' -i ${PROXY_DIR}/docker-compose.yml
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        sed -e '/ACME_CA_URI/ s/^#*/#/' -i '' ${PROXY_DIR}/docker-compose.yml
    fi
    echo "[Proxy] Use Let's encrypt server"
else
    echo "[Proxy] Use Let's encrypt TEST SERVER"
fi

echo "[Proxy] Generate docker-compose for proxy success"

