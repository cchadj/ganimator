#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <experiments.csv>"
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
tail -n +2 "$input" | while IFS=',' read -r BVH_PREFIX BVH_NAME SAVE_PATH START END
do
  # Skip empty lines
  if [ -z "$BVH_PREFIX" ] || [ -z "$BVH_NAME" ] || [ -z "$SAVE_PATH" ] || [ -z "$START" ] || [ -z "$END" ]; then
    continue
  fi

  # Export variables
  export BVH_PREFIX="$BVH_PREFIX"
  export BVH_NAME="$BVH_NAME"
  export SAVE_PATH="$SAVE_PATH"
  export START="$START"
  export END="$END"

  echo $BVH_PREFIX $BVH_NAME $SAVE_PATH $START $END
  # Execute the sbatch command
  echo $(sbatch scripts/train.sh)
done

