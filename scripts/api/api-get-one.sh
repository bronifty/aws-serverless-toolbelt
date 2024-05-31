#!/bin/bash
# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Source the scripts using the script directory path
source $SCRIPT_DIR/../variables.sh

# Check if a function name was passed as an argument
if [ -z "$1" ]; then
    echo "No api name provided. Using default function name."
    API_NAME=$DEFAULT_API_NAME
else
    API_NAME=$1  # Set the function name from the first script argument
fi

aws apigatewayv2 get-apis | jq -r --arg API_NAME "$API_NAME" '.Items[] | select(.Name == $API_NAME) | .ApiId'