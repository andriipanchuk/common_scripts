#!/bin/sh
## Use following container vault:1.4.0
## Make sure folder name is not ending with /
sleep 20
KEYS_FOLDER="."
VAULT_ENDPOINT="http://127.0.0.1:8200/v1/sys/unseal"

MASTER_KEYS=$(vault operator init -recovery-shares=5 -recovery-threshold=3 | grep -e "2:\|3:\|4:" |  awk '{print $4}')

KEY_NUMBER=1
for key in $MASTER_KEYS
do
    echo '{"key": "'"$key"'"}' > "$KEYS_FOLDER/master_keys_$KEY_NUMBER.json"
    curl --request PUT --data @"$KEYS_FOLDER/master_keys_$KEY_NUMBER.json" "$VAULT_ENDPOINT"
    KEY_NUMBER=$(( $KEY_NUMBER + 1 ))
done

export KEYS_FOLDER="$(echo $KEYS_FOLDER)"

