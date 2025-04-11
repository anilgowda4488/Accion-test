#!/bin/bash

LOG_FILE="system.log"

if grep -q 'ERROR' "$LOG_FILE"; then
  awk '/ERROR/ {print toupper(substr($0, index($0, "ERROR")))}' "$LOG_FILE"

  echo ""
  echo "Extracting and transforming ERROR messages:"
  grep 'ERROR' "$LOG_FILE" | sed 's/.*ERROR: /ISSUE: /' | tr '[:lower:]' '[:upper:]'
else
  echo "No error found"
fi
