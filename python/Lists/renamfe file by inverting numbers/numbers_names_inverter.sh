#!/bin/bash

# Check if an argument was provided
if [ -n "$1" ]; then
    directory="$1"
else
    read -p "Enter the directory path: " directory
fi

directory=$(echo "$directory" | sed 's/\\/\//g')  # Normalize paths (replace backslashes with slashes)

script_path="/path/to/your/script/rename_script.py"  # Replace with the actual script path

if [[ ! -f "$script_path" ]]; then
    echo "Error: The file $script_path does not exist. Check the path."
    exit 1
fi

python3 "$script_path" "$directory"
