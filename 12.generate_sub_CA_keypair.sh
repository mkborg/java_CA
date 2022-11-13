#!/bin/bash -eux

. 01.root_CA.config.sh
. 02.sub_CA.config.sh

keytool \
  -genkeypair \
  ${SUB_CA_KEY_STORE_OPTION} \
  ${SUB_CA_KEY_STORE_PASSWORD_OPTION} \
  -alias "${SUB_CA_KEY_ID}" \
  ${SUB_CA_KEY_PASSWORD_OPTION} \
  -dname "${SUB_CA_DISTINGUISHED_NAME}" \
  -ext bc:c \

keytool \
  -certreq \
  ${SUB_CA_KEY_STORE_OPTION} \
  ${SUB_CA_KEY_STORE_PASSWORD_OPTION} \
  -alias "${SUB_CA_KEY_ID}" \
  ${SUB_CA_KEY_PASSWORD_OPTION} \
  -file "${SUB_CA_KEY_ID}".csr \

keytool \
  -printcertreq \
  -file "${SUB_CA_KEY_ID}".csr \
  -v \


# shall be done by 'root CA'
keytool \
  -gencert \
  ${ROOT_CA_KEY_STORE_OPTION} \
  ${ROOT_CA_KEY_STORE_PASSWORD_OPTION} \
  -alias "${ROOT_CA_KEY_ID}" \
  ${ROOT_CA_KEY_PASSWORD_OPTION} \
  -ext BC=0 \
  -rfc \
  -infile "${SUB_CA_KEY_ID}".csr \
  -outfile "${SUB_CA_KEY_ID}".pem \

rm -fv "${SUB_CA_KEY_ID}".csr


keytool \
  -importcert \
  ${SUB_CA_KEY_STORE_OPTION} \
  ${SUB_CA_KEY_STORE_PASSWORD_OPTION} \
  -alias "${ROOT_CA_KEY_ID}"_certificate \
  -file "${ROOT_CA_KEY_ID}".pem \
  -noprompt \
  -trustcacerts \

keytool \
  -importcert \
  ${SUB_CA_KEY_STORE_OPTION} \
  ${SUB_CA_KEY_STORE_PASSWORD_OPTION} \
  -alias "${SUB_CA_KEY_ID}" \
  ${SUB_CA_KEY_PASSWORD_OPTION} \
  -file "${SUB_CA_KEY_ID}".pem \


keytool \
  -list \
  ${SUB_CA_KEY_STORE_OPTION} \
  ${SUB_CA_KEY_STORE_PASSWORD_OPTION} \
  -v \

