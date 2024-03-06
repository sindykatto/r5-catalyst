#!/bin/bash

# Import environment variables
source .env

# Create associative array
declare -A nidHashToPlayerName

# Loop through all JSON files
for file in $OUTPUT_DIR/*.json; do
  # Extract playerName and nidHash
  while read -r playerName nidHash; do
    # Check if playerName is not in the array
    if [[ ! ${nidHashToPlayerName[$nidHash]} =~ $playerName ]]; then
      nidHashToPlayerName[$nidHash]+="$playerName, "
    fi
  done < <(jq -r '.matches[0].player_results[] | "\(.playerName) \(.nidHash)"' $file)
done

# Create or overwrite the output file
: > $OUTPUT_MARKDOWN
for nidHash in "${!nidHashToPlayerName[@]}"; do
  echo -e "$nidHash" >> $OUTPUT_MARKDOWN
  # Display each playerName
  IFS=', ' read -r -a playerNameArray <<< "${nidHashToPlayerName[$nidHash]}"
  for playerName in "${playerNameArray[@]}"; do
    echo -e " - $playerName" >> $OUTPUT_MARKDOWN
  done
  echo "" >> $OUTPUT_MARKDOWN
done
echo "Output stored in $OUTPUT_MARKDOWN"