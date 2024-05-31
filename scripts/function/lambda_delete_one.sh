#!/bin/bash

# Check if a function name was passed as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <function-name>"
    exit 1
fi

# Delete a Lambda function given its name
function_name=$1
aws lambda delete-function --function-name "$function_name"