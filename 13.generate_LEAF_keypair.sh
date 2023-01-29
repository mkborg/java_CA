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
  > "${LEAF_KEY_ID}".csr.txt \


# mk: Note: 'keytool -gencert' produces 'certificate chain'

# shall be done by 'sub CA'
keytool \
  -gencert \
  ${SUB_CA_KEY_STORE_OPTION} \
  ${SUB_CA_KEY_STORE_PASSWORD_OPTION} \
  -alias "${SUB_CA_KEY_ID}" \
  ${SUB_CA_KEY_PASSWORD_OPTION} \
  -ext BC=0 \
  -infile "${LEAF_KEY_ID}".csr \
  -outfile "${LEAF_KEY_ID}".der \

# mk: 'keytool -printcert -rfc' can be used to convert '.der' to '.pem'.
# mk: It can convert 'certificate chain'. as well.
keytool \
  -printcert \
  -rfc \
  -file "${LEAF_KEY_ID}".der \
  > "${LEAF_KEY_ID}".der.pem \

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

keytool \
  -printcert \
  -file "${LEAF_KEY_ID}".der \
  > "${LEAF_KEY_ID}".der.txt \

keytool \
  -printcert \
  -file "${LEAF_KEY_ID}".der.pem \
  > "${LEAF_KEY_ID}".der.pem.txt \

keytool \
  -printcert \
  -file "${LEAF_KEY_ID}".pem \
  > "${LEAF_KEY_ID}".pem.txt \


# Note: Only 'root CA' needs '-trustcacerts'
keytool \
  -importcert \
  ${LEAF_KEY_STORE_OPTION} \
  ${LEAF_KEY_STORE_PASSWORD_OPTION} \
  -alias "${ROOT_CA_KEY_ID}"_certificate \
  -file "${ROOT_CA_KEY_ID}".pem \
  -noprompt \
  -trustcacerts \

# mk: Certificate produced with 'keytool -gencert' contains complete
# 'certificate chain' so only 'Root CA' certificate shall be really
# necessary while all intermediate certificates can be omitted.

# mk: If ceritificate of intermediate CA is missing in keystore then
# certificate of Root CA is automatically added to 'leaf' certificate
# chain stored in keystore by 'keytool -importcert'.

#keytool \
#  -importcert \
#  ${LEAF_KEY_STORE_OPTION} \
#  ${LEAF_KEY_STORE_PASSWORD_OPTION} \
#  -alias "${SUB_CA_KEY_ID}"_certificate \
#  -file "${SUB_CA_KEY_ID}".pem \

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
  > "${LEAF_KEY_STORE}.txt" \

keytool \
  -list \
  ${LEAF_KEY_STORE_OPTION} \
  ${LEAF_KEY_STORE_PASSWORD_OPTION} \
  -v \
  > "${LEAF_KEY_STORE}.-v.txt" \

keytool \
  -list \
  ${LEAF_KEY_STORE_OPTION} \
  ${LEAF_KEY_STORE_PASSWORD_OPTION} \
  -rfc \
  > "${LEAF_KEY_STORE}.-rfc.txt" \

keytool \
  -list \
  ${LEAF_KEY_STORE_OPTION} \
  ${LEAF_KEY_STORE_PASSWORD_OPTION} \
  -alias "${LEAF_KEY_ID}" \
  -rfc \
  > "${LEAF_KEY_STORE}.-rfc.${LEAF_KEY_ID}.txt" \

keytool \
  -printcert \
  -file "${LEAF_KEY_STORE}.-rfc.${LEAF_KEY_ID}.txt" \
  > "${LEAF_KEY_STORE}.-rfc.${LEAF_KEY_ID}.txt.txt" \


# > "the first certificate in the chain is returned"
keytool \
  -exportcert \
  ${LEAF_KEY_STORE_OPTION} \
  ${LEAF_KEY_STORE_PASSWORD_OPTION} \
  -alias "${LEAF_KEY_ID}" \
  -rfc \
  > "${LEAF_KEY_ID}".exported.pem \

keytool \
  -exportcert \
  ${LEAF_KEY_STORE_OPTION} \
  ${LEAF_KEY_STORE_PASSWORD_OPTION} \
  -alias "${LEAF_KEY_ID}" \
  > "${LEAF_KEY_ID}".exported.der \

keytool \
  -printcert \
  -file "${LEAF_KEY_ID}".exported.pem \
  > "${LEAF_KEY_ID}".exported.pem.txt \

keytool \
  -printcert \
  -file "${LEAF_KEY_ID}".exported.der \
  > "${LEAF_KEY_ID}".exported.der.txt \

