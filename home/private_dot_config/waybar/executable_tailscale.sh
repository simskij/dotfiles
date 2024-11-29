#!/bin/bash

STATUS=$(curl --silent --fail --unix-socket /run/tailscale/tailscaled.sock http://local-tailscaled.sock/localapi/v0/status | jq -r .Self.Online)

if [[ "$1" == "toggle" ]]; then
  if [[ "$STATUS" == "true" ]]; then
    tailscale down &
  else
    tailscale up --operator=simme --reset --ssh &
  fi
fi

ICON="󰖂 " 

if "$STATUS" -eq "true"; then
  CLASS="connected"
else
  CLASS="disconnected"
fi

echo "{ \"text\": \"$ICON\", \"tooltip\": \"Connected to Tailnet\", \"class\": \"$CLASS\" }"
