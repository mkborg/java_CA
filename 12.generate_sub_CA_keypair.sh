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
  > "${SUB_CA_KEY_ID}".csr.txt \


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
  -printcert \
  -file "${SUB_CA_KEY_ID}".pem \
  > "${SUB_CA_KEY_ID}".pem.txt \


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
  > "${SUB_CA_KEY_STORE}.txt" \

keytool \
  -list \
  ${SUB_CA_KEY_STORE_OPTION} \
  ${SUB_CA_KEY_STORE_PASSWORD_OPTION} \
  -v \
  > "${SUB_CA_KEY_STORE}.-v.txt" \

keytool \
  -list \
  ${SUB_CA_KEY_STORE_OPTION} \
  ${SUB_CA_KEY_STORE_PASSWORD_OPTION} \
  -rfc \
  > "${SUB_CA_KEY_STORE}.-rfc.txt" \

#keytool \
#  -list \
#  ${SUB_CA_KEY_STORE_OPTION} \
#  ${SUB_CA_KEY_STORE_PASSWORD_OPTION} \
#  -alias "${SUB_CA_KEY_ID}" \
#  -rfc \
#  > "${SUB_CA_KEY_STORE}.-rfc.${SUB_CA_KEY_ID}.txt" \


#keytool \
#  -exportcert \
#  ${SUB_CA_KEY_STORE_OPTION} \
#  ${SUB_CA_KEY_STORE_PASSWORD_OPTION} \
#  -alias "${SUB_CA_KEY_ID}" \
#  -rfc \
#  > "${SUB_CA_KEY_ID}".exported.pem \

keytool \
  -exportcert \
  ${SUB_CA_KEY_STORE_OPTION} \
  ${SUB_CA_KEY_STORE_PASSWORD_OPTION} \
  -alias "${SUB_CA_KEY_ID}" \
  > "${SUB_CA_KEY_ID}".exported.der \


#keytool \
#  -printcert \
#  -file "${SUB_CA_KEY_ID}".exported.pem \
#  > "${SUB_CA_KEY_ID}".exported.pem.txt \

#keytool \
#  -printcert \
#  -file "${SUB_CA_KEY_ID}".exported.der \
#  > "${SUB_CA_KEY_ID}".exported.der.txt \

