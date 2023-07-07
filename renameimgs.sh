#!/bin/bash

# Use the find command to locate all the png files
find . -name "*.png" -type f | while read -r file; do
    # Extract the file name and directory path
    directory=$(dirname "$file")
    filename=$(basename "$file")

    # Replace spaces with underscores in the file name using tr(translate)
    new_filename=$(echo "$filename" | tr ' ' '_')

    # Construct the new file path with the renamed file
    new_file="$directory/$new_filename"

    # Rename the file
    mv "$file" "$new_file"
    echo "Renamed: $file -> $new_file"
done
