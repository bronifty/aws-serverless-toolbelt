#!/bin/bash
# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Source the scripts using the script directory path
source $SCRIPT_DIR/variables.sh

# Clean previous installs
source $SCRIPT_DIR/clean.sh

  # Check if a function name was passed as an argument
   if [ -z "$1" ]; then
       echo "No function name provided. Using default function name."
       FUNCTION_NAME=$DEFAULT_FUNCTION_NAME
   else
       FUNCTION_NAME=$1  # Set the function name from the first script argument
   fi

# Install production dependencies
pnpm install --shamefully-hoist --prod

# Create a zip file for deployment
zip -r $FUNCTION_NAME.zip . -x "*.git*" 

# Print the size of the zip file
du -h $FUNCTION_NAME.zip
