#!/bin/bash -eux

. 01.root_CA.config.sh
. 02.sub_CA.config.sh
. 03.leaf.config.sh

keytool \
  -genkeypair \
  ${LEAF_KEY_STORE_OPTION} \
  ${LEAF_KEY_STORE_PASSWORD_OPTION} \
  -alias "${LEAF_KEY_ID}" \
  ${LEAF_KEY_PASSWORD_OPTION} \
  -dname "${LEAF_DISTINGUISHED_NAME}" \
  -ext bc:c \

keytool \
  -certreq \
  ${LEAF_KEY_STORE_OPTION} \
  ${LEAF_KEY_STORE_PASSWORD_OPTION} \
  -alias "${LEAF_KEY_ID}" \
  ${LEAF_KEY_PASSWORD_OPTION} \
  -file "${LEAF_KEY_ID}".csr \

keytool \
  -printcertreq \
  -file "${LEAF_KEY_ID}".csr \
  -v \


# shall be done by 'sub CA'
keytool \
  -gencert \
  ${SUB_CA_KEY_STORE_OPTION} \
  ${SUB_CA_KEY_STORE_PASSWORD_OPTION} \
  -alias "${SUB_CA_KEY_ID}" \
  ${SUB_CA_KEY_PASSWORD_OPTION} \
  -ext BC=0 \
  -rfc \
  -infile "${LEAF_KEY_ID}".csr \
  -outfile "${LEAF_KEY_ID}".pem \

rm -fv "${LEAF_KEY_ID}".csr


# Note: Only 'root CA' needs '-trustcacerts'
keytool \
  -importcert \
  ${LEAF_KEY_STORE_OPTION} \
  ${LEAF_KEY_STORE_PASSWORD_OPTION} \
  -alias "${ROOT_CA_KEY_ID}"_certificate \
  -file "${ROOT_CA_KEY_ID}".pem \
  -noprompt \
  -trustcacerts \

keytool \
  -importcert \
  ${LEAF_KEY_STORE_OPTION} \
  ${LEAF_KEY_STORE_PASSWORD_OPTION} \
  -alias "${SUB_CA_KEY_ID}"_certificate \
  -file "${SUB_CA_KEY_ID}".pem \

keytool \
  -importcert \
  ${LEAF_KEY_STORE_OPTION} \
  ${LEAF_KEY_STORE_PASSWORD_OPTION} \
  -alias "${LEAF_KEY_ID}" \
  ${LEAF_KEY_PASSWORD_OPTION} \
  -file "${LEAF_KEY_ID}".pem \


keytool \
  -list \
  ${LEAF_KEY_STORE_OPTION} \
  ${LEAF_KEY_STORE_PASSWORD_OPTION} \
  -v \

