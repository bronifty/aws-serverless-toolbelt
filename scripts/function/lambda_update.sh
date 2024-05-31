#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Check if a function name was passed as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <function-name>"
    exit 1
fi

FUNCTION_NAME=$1  # Set the function name from the first script argument


aws lambda update-function-code --function-name $FUNCTION_NAME --zip-file fileb://$FUNCTION_NAME.zip
