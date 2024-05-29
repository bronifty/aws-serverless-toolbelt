#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Source the scripts using the script directory path
source "$SCRIPT_DIR/variables.sh"

aws lambda create-function \
    --function-name $FUNCTION_NAME \
    --runtime $LAMBDA_RUNTIME \
    --role $LAMBDA_ROLE \
    --handler $LAMBDA_HANDLER \
    --zip-file fileb://$FUNCTION_NAME.zip \
