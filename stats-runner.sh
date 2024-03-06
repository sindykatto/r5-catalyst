#!/bin/bash

# Source from .env
source .env

# Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Iterate over keys
for key in ${keys[@]}; do
  # Use curl to send GET request to API and save response to file
  curl -s $API_URL?token=$key -o $OUTPUT_DIR/$key.json
  echo "Response for key $key saved to $OUTPUT_DIR/$key.json"
done