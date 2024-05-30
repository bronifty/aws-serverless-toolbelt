#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Source the scripts using the script directory path
source "$SCRIPT_DIR/../variables.sh"

aws lambda list-functions --query 'Functions[*].FunctionName' --output text | while read -r function_name; do
    aws lambda delete-function --function-name "$function_name"
    echo "Deleted function $function_name"
done