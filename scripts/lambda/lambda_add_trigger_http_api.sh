#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Source the scripts using the script directory path
source "$SCRIPT_DIR/../variables.sh"

aws apigatewayv2 create-api --name $HTTP_API_NAME --protocol-type 'HTTP' --target arn:aws:lambda:$REGION:$ACCOUNT_ID:function:$FUNCTION_NAME