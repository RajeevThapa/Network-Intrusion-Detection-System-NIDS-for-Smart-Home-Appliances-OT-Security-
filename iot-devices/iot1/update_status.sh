#!/bin/sh
BROKER="localhost"
TOPIC="vm2/lightbulb/status"
OUTFILE="/home/vagrant/iot/www/status.txt"
LOGFILE="/home/vagrant/iot/update_status.log"

mkdir -p "$(dirname "$OUTFILE")"
touch "$OUTFILE" "$LOGFILE"

while true; do
  echo "$(date): Waiting for message..." >> "$LOGFILE"
  
  # Use a temporary file first to avoid race conditions
  TEMPFILE=$(mktemp)
  mosquitto_sub -h "$BROKER" -t "$TOPIC" -C 1 > "$TEMPFILE"
  
  if [ -s "$TEMPFILE" ]; then
    mv "$TEMPFILE" "$OUTFILE"
    echo "$(date): Message written: $(cat $OUTFILE)" >> "$LOGFILE"
  else
    echo "$(date): Empty message received or error." >> "$LOGFILE"
    rm -f "$TEMPFILE"
  fi

  sleep 1
done
