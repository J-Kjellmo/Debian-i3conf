#!/bin/bash
# File to make all files in /scripts executable

# Define the target directory
TARGET_DIR="$HOME/.config/i3/scripts"

# Check if the directory exists
if [ ! -d "$TARGET_DIR" ]; then
  echo "Directory $TARGET_DIR does not exist."
  exit 1
fi

# Iterate over files in the directory (not including subfolders)
for file in "$TARGET_DIR"/*; do
  if [ -f "$file" ]; then
    chmod +x "$file"
    echo "Made executable: $file"
  fi
done

echo "All files in $TARGET_DIR are now executable."
