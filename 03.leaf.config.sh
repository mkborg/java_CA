
LEAF_KEY_ID="leaf"
LEAF_DISTINGUISHED_NAME="CN=${LEAF_KEY_ID}"

# 'STORE' is always a 'file' so '_FILE' suffix is not necessary ('STORE_FILE')
LEAF_KEY_STORE="${LEAF_KEY_ID}_keystore.jks"
#LEAF_KEY_STORE_PASSWORD="LEAF_KEY_STORE_PASSWORD"
LEAF_KEY_STORE_PASSWORD_FILE="PASSWORDs/${LEAF_KEY_ID}_KEY_STORE_PASSWORD.txt"

LEAF_KEY_STORE_OPTION="-keystore ${LEAF_KEY_STORE}"
#LEAF_KEY_STORE_PASSWORD_OPTION="-storepass ${LEAF_KEY_STORE_PASSWORD}"
LEAF_KEY_STORE_PASSWORD_OPTION="-storepass:file ${LEAF_KEY_STORE_PASSWORD_FILE}"


#LEAF_KEY_PASSWORD="LEAF_KEY_PASSWORD"
LEAF_KEY_PASSWORD_FILE="PASSWORDs/${LEAF_KEY_ID}_KEY_PASSWORD.txt"

LEAF_KEY_OPTION="-keystore ${LEAF_KEY_STORE}"
#LEAF_KEY_PASSWORD_OPTION="-storepass ${LEAF_KEY_PASSWORD}"
LEAF_KEY_PASSWORD_OPTION="-keypass:file ${LEAF_KEY_PASSWORD_FILE}"
