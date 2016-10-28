#!/usr/bin/env bash
set -eu pipefail
SLEEP_TIME="${CERTBOT_INTERVAL:-1d}"
OUTPUT_LOCATION="${CERTBOT_OUTPUT:-/certs}"

DEHYDRATED_DIR=/srv/dehydrated
function dehydrated {
  "${DEHYDRATED_DIR}/dehydrated" $@
}


dehydrated --register --accept-terms
while :;
do
  dehydrated --cron --hook "$DEHYDRATED_DIR/dehydrated.default.sh" --challenge dns-01 --domain "${CERTBOT_DOMAIN}" --out "$OUTPUT_LOCATION"
  echo "Sleeping for $SLEEP_TIME until next check. (Poor man's cron)"
  sleep "$SLEEP_TIME"
done
