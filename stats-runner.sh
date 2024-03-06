#!/bin/bash

# Load environment variables
source .env
source $KEYS_FILE

# Ensure output directory exists
mkdir -p $OUTPUT_DIR

# Function to fetch API data
fetch_data() {
  local key=$1
  local output_file="$OUTPUT_DIR/$key.json"

  echo "Fetching data for key: $key"
  curl -s "$API_URL?token=$key" -o $output_file
  echo "Response saved to $output_file"
}

# Fetch data for each key
for key in ${keys[@]}; do
  fetch_data $key
done
