#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <samples.csv>"
  exit 1
fi

# Assign the first argument to the input variable
input="$1"

# Check if the file exists
if [ ! -f "$input" ]; then
  echo "File not found: $input"
  exit 1
fi


# Skip the header and iterate over each line
tail -n +2 "$input" | while IFS=',' read -r SAVE_PATH TARGET_LENGTH BVH_DIR
do
  # Skip empty lines
  if [ -z "$SAVE_PATH" ] || [ -z "$TARGET_LENGTH" ] || [ -z "$BVH_DIR" ]; then
    continue
  fi

  # Export variables
  export SAVE_PATH="$SAVE_PATH"
  export TARGET_LENGTH="$TARGET_LENGTH"
  export BVH_DIR="$BVH_DIR"

  echo $SAVE_PATH $TARGET_LENGTH $BVH_DIR
  # Execute the sbatch command
  echo $(sbatch scripts/generate_samples.sh)
done

