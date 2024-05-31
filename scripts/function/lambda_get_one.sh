#!/bin/bash

# Check if a function name was passed as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <function-name>"
    exit 1
fi

# Get the function name from the command line
FUNCTION_NAME=$1

# Get the function configuration
aws lambda get-function-configuration --function-name $FUNCTION_NAME
