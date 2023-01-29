#!/bin/bash -eux

. 01.root_CA.config.sh
. 02.sub_CA.config.sh
. 03.leaf.config.sh

# Warning:  Different store and key passwords not supported for PKCS12 KeyStores.
# Ignoring user-specified -destkeypass value.

# keytool error: java.lang.Exception: The destination pkcs12 keystore has different storepass and keypass.
# Please retry with -destkeypass specified.


keytool \
  -importkeystore \
  -srckeystore ${LEAF_KEY_STORE} \
  -srcstorepass:file ${LEAF_KEY_STORE_PASSWORD_FILE} \
  -srcalias "${LEAF_KEY_ID}" \
  -srckeypass:file ${LEAF_KEY_PASSWORD_FILE} \
  -deststoretype PKCS12 \
  -destkeystore ${LEAF_KEY_STORE}.p12 \
  -deststorepass:file ${LEAF_KEY_STORE_PASSWORD_FILE} \
  -destalias "${LEAF_KEY_ID}" \
  -destkeypass:file ${LEAF_KEY_STORE_PASSWORD_FILE} \

openssl \
  pkcs12 \
  -in ${LEAF_KEY_STORE}.p12 \
  -nocerts \
  -nodes \
  -out "${LEAF_KEY_ID}.private.pem" \

openssl \
  pkcs12 \
  -in ${LEAF_KEY_STORE}.p12 \
  -nokeys \
  -out "${LEAF_KEY_ID}.cert.pem" \

