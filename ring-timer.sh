#!/bin/bash

# Import environment variables
source .env

# Find objects with ring-related categories
jq '[.[] | select(.category=="ringStartClosing" or .category=="ringFinishedClosing")]' $INPUT_JSON > $OUTPUT_JSON

# Get timestamp differences
function get_time_differences() {
    # Read the JSON data
    data=$(cat $OUTPUT_JSON)

    # Use jq to extract the timestamps and sort them
    timestamps=$(echo "$data" | jq -r '.[] | .timestamp' | sort -n)

    # Initialize the previous timestamp
    prev_ts=0

    # Loop through the timestamps
    while read -r ts; do
        # Convert timestamp to integer
        ts_int=$(echo $ts | tr -d '"')

        # If this is not the first timestamp
        if [[ $prev_ts != 0 ]]; then
            # Calculate the difference and print it
            diff=$(($ts_int - $prev_ts))
            echo "Difference: $diff"
        fi
        # Update the previous timestamp
        prev_ts=$ts_int
    done <<< "$timestamps"
}

get_time_differences
