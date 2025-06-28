#!/bin/sh
DEVICE_ID="vm2"
BROKER="localhost"

# Initial state
STATE="off"
COLOR="white"

mosquitto_sub -h $BROKER -t "$DEVICE_ID/lightbulb/set" | while read CMD; do
  echo "[LIGHTBULB] Received command: $CMD"
  # parse command (simple: on/off, color=red/green/blue)
  if echo "$CMD" | grep -q "on"; then STATE="on"; fi
  if echo "$CMD" | grep -q "off"; then STATE="off"; fi
  if echo "$CMD" | grep -q "color="; then
#    COLOR=$(echo $CMD | cut -d '=' -f2)
    # (for vulnerability): This makes the color field vulnerable to command injection
    eval "COLOR=$(echo $CMD | cut -d '=' -f2)"
  fi
  # Publish new state
  mosquitto_pub -h $BROKER -t "$DEVICE_ID/lightbulb/status" -m "state=$STATE,color=$COLOR"
done

