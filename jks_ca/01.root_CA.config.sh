
ROOT_CA_KEY_ID="root_CA"
ROOT_CA_DISTINGUISHED_NAME="CN=${ROOT_CA_KEY_ID}"

# 'STORE' is always a 'file' so '_FILE' suffix is not necessary ('STORE_FILE')
ROOT_CA_JKS_KEY_STORE="${ROOT_CA_KEY_ID}_keystore.jks"
ROOT_CA_P12_KEY_STORE="${ROOT_CA_KEY_ID}_keystore.p12"

ROOT_CA_KEY_STORE="${ROOT_CA_JKS_KEY_STORE}"
#ROOT_CA_KEY_STORE="${ROOT_CA_P12_KEY_STORE}"

#ROOT_CA_JKS_KEY_STORE_OPTION="-keystore ${ROOT_CA_JKS_KEY_STORE}"
#ROOT_CA_P12_KEY_STORE_OPTION="-keystore ${ROOT_CA_P12_KEY_STORE}"

#ROOT_CA_KEY_STORE_OPTION="${ROOT_CA_JKS_KEY_STORE_OPTION}"
#ROOT_CA_KEY_STORE_OPTION="${ROOT_CA_P12_KEY_STORE_OPTION}"

ROOT_CA_KEY_STORE_OPTION="-keystore ${ROOT_CA_KEY_STORE}"

# Note: 'pkcs#12' expects both 'keystore password' and 'key password' to be equal

#ROOT_CA_PASSWORD="ROOT_CA_PASSWORD"
ROOT_CA_PASSWORD_FILE="PASSWORDs/${ROOT_CA_KEY_ID}_PASSWORD.txt"

#ROOT_CA_KEY_STORE_PASSWORD_OPTION="-storepass ${ROOT_CA_PASSWORD}"
ROOT_CA_KEY_STORE_PASSWORD_OPTION="-storepass:file ${ROOT_CA_PASSWORD_FILE}"

#ROOT_CA_KEY_PASSWORD_OPTION="-storepass ${ROOT_CA_PASSWORD}"
ROOT_CA_KEY_PASSWORD_OPTION="-keypass:file ${ROOT_CA_PASSWORD_FILE}"
