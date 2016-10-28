#!/usr/bin/env bash
set -eu
SLEEP_TIME="${CERTBOT_INTERVAL:-1d}"
OUTPUT_LOCATION="${CERTBOT_OUTPUT:-/certs}"

while :;
do
  DEHYDRATED_DIR=/dehydrated
  echo "Running dehydrated"

  "$DEHYDRATED_DIR/dehydrated" --cron --hook "$DEHYDRATED_DIR/dehydrated.default.sh" --challenge dns-01 --domain "$CERTBOT_DOMAIN" --out "$OUTPUT_LOCATION"


  echo "Sleeping for $SLEEP_TIME until next check."
  sleep "$SLEEP_TIME"
done
