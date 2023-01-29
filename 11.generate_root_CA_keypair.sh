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
  -exportcert \
  ${ROOT_CA_KEY_STORE_OPTION} \
  ${ROOT_CA_KEY_STORE_PASSWORD_OPTION} \
  -alias "${ROOT_CA_KEY_ID}" \
  > "${ROOT_CA_KEY_ID}".der \


# mk: 'keytool -printcert' without '-rfc' can be used to convert '.der' or '.pem' to human readable form

#keytool \
#  -printcert \
#  -rfc \
#  -file "${ROOT_CA_KEY_ID}".pem \
#  > "${ROOT_CA_KEY_ID}".pem.pem \

keytool \
  -printcert \
  -file "${ROOT_CA_KEY_ID}".pem \
  > "${ROOT_CA_KEY_ID}".pem.txt \


# mk: 'keytool -printcert -rfc' can be used to convert '.der' to '.pem'
# mk: It can convert 'certificate chain'. as well.

#keytool \
#  -printcert \
#  -rfc \
#  -file "${ROOT_CA_KEY_ID}".der \
#  > "${ROOT_CA_KEY_ID}".der.pem \

#keytool \
#  -printcert \
#  -file "${ROOT_CA_KEY_ID}".der \
#  > "${ROOT_CA_KEY_ID}".der.txt \



keytool \
  -list \
  ${ROOT_CA_KEY_STORE_OPTION} \
  ${ROOT_CA_KEY_STORE_PASSWORD_OPTION} \
  > "${ROOT_CA_KEY_STORE}.txt" \

keytool \
  -list \
  ${ROOT_CA_KEY_STORE_OPTION} \
  ${ROOT_CA_KEY_STORE_PASSWORD_OPTION} \
  -v \
  > "${ROOT_CA_KEY_STORE}.-v.txt" \

keytool \
  -list \
  ${ROOT_CA_KEY_STORE_OPTION} \
  ${ROOT_CA_KEY_STORE_PASSWORD_OPTION} \
  -rfc \
  > "${ROOT_CA_KEY_STORE}.-rfc.txt" \

#keytool \
#  -list \
#  ${ROOT_CA_KEY_STORE_OPTION} \
#  ${ROOT_CA_KEY_STORE_PASSWORD_OPTION} \
#  -alias "${ROOT_CA_KEY_ID}" \
#  -rfc \
#  > "${ROOT_CA_KEY_STORE}.-rfc.${ROOT_CA_KEY_ID}.txt" \

