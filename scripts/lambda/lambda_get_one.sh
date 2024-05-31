#!/bin/bash

# Get the function name from the command line
FUNCTION_NAME=$1

# Get the function configuration
aws lambda get-function-configuration --function-name $FUNCTION_NAME
