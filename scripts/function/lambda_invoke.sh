#!/bin/bash

# Check if a function name was passed as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <function-name>"
    exit 1
fi

FUNCTION_NAME=$1  # Set the function name from the first script argument

aws lambda invoke \
    --function-name $FUNCTION_NAME \
    --cli-binary-format raw-in-base64-out \
    --payload '{"exampleKey":"exampleValue"}' \
    outputfile.txt