#!/bin/bash

STARTDATE=2023-05-24
ENDDATE=2023-07-24

start_timestamp=$(date -d "$STARTDATE" +%s)
end_timestamp=$(date -d "$ENDDATE" +%s)

current_timestamp="$start_timestamp"
day_counter=0

while [[ "$current_timestamp" -le "$end_timestamp" ]]; do
    
    # Exclude weekends Sat-6, Sun-7 
    day_of_week=$(date -d @"$current_timestamp" +%u)
    if [[ "$day_of_week" == 6 || "$day_of_week" == 7 ]]; then
        current_timestamp=$((current_timestamp + 86400))  # Add 86400 seconds (1 day)
        continue #skip to next iter
    fi

    current_date=$(date -d @"$current_timestamp" +%d%m%y)
    day_str=$(printf "%02d" $day_counter)
    echo Day"$day_str"-"$current_date"
    mkdir Day"$day_str"-"$current_date"

    current_timestamp=$((current_timestamp + 86400))  # Add 86400 seconds (1 day)
    ((day_counter++))
done
