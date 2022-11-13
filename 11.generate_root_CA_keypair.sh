#!/bin/bash -eux

. 01.root_CA.config.sh

# BC or BasicConstraints
#
#    Values: The full form is: ca:{true|false}[,pathlen:<len>] or <len>,
#    which is short for ca:true,pathlen:<len>. When <len> is omitted, you
#    have ca:true.

keytool \
  -genkeypair \
  ${ROOT_CA_KEY_STORE_OPTION} \
  ${ROOT_CA_KEY_STORE_PASSWORD_OPTION} \
  -alias "${ROOT_CA_KEY_ID}" \
  ${ROOT_CA_KEY_PASSWORD_OPTION} \
  -dname "${ROOT_CA_DISTINGUISHED_NAME}" \
  -ext bc:c \

# When -rfc is specified, the output format is Base64-encoded PEM;
# otherwise, a binary DER is created

keytool \
  -exportcert \
  ${ROOT_CA_KEY_STORE_OPTION} \
  ${ROOT_CA_KEY_STORE_PASSWORD_OPTION} \
  -alias "${ROOT_CA_KEY_ID}" \
  -rfc \
  > "${ROOT_CA_KEY_ID}".pem \


keytool \
  -list \
  ${ROOT_CA_KEY_STORE_OPTION} \
  ${ROOT_CA_KEY_STORE_PASSWORD_OPTION} \
  -v \

