#!/bin/bash

DOMAIN="${DOMAIN:-b.com}"
CERT_DIR="${CERT_DIR:-/cert}"
FILE_NAME="${FILE_NAME:-dev}"
KEY_PATH="${KEY_PATH:-${CERT_DIR}/${FILE_NAME}.key}"
CSR_PATH="${CSR_PATH:-${CERT_DIR}/${FILE_NAME}.csr}"
CRT_PATH="${CRT_PATH:-${CERT_DIR}/${FILE_NAME}.crt}"

if [ -f "${CRT_PATH}" ]; then
  exit 0
fi

openssl req -nodes -new -newkey rsa:2048 -keyout "${KEY_PATH}" -out "${CSR_PATH}" -sha256 -config <(
cat <<-EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn

[ dn ]
C=ZZ
ST=ZZ
L=Solid Ground
O=Developer
OU=Dev Domain
emailAddress=admin@${DOMAIN}
CN=*.${DOMAIN}
EOF
)

openssl x509 -req -days 750 -in "${CSR_PATH}" -signkey "${KEY_PATH}" -sha256 -out "${CRT_PATH}" -extfile <(
cat <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${DOMAIN}
DNS.2 = *.${DOMAIN}
EOF
)
