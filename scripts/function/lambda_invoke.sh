#!/bin/bash

# Check if a function name was passed as an argument
   if [ -z "$1" ]; then
       echo "No function name provided. Using default function name."
       FUNCTION_NAME=$DEFAULT_FUNCTION_NAME
   else
       FUNCTION_NAME=$1  # Set the function name from the first script argument
   fi

aws lambda invoke \
    --function-name $FUNCTION_NAME \
    --cli-binary-format raw-in-base64-out \
    --payload '{"exampleKey":"exampleValue"}' \
    outputfile.txt