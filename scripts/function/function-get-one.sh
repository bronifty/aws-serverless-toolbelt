# #!/bin/bash
# # Get the directory where the script is located
# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# # Source the scripts using the script directory path
# source $SCRIPT_DIR/../variables.sh

# # Check if a function name was passed as an argument
# if [ -z "$1" ]; then
#     echo "No function name provided. Using default function name."
#     FUNCTION_NAME=$DEFAULT_FUNCTION_NAME
# else
#     FUNCTION_NAME=$1  # Set the function name from the first script argument
# fi

# # Get the function configuration
# aws lambda get-function-configuration --function-name $FUNCTION_NAME

#!/bin/bash
# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Source the scripts using the script directory path
source $SCRIPT_DIR/../variables.sh

# Check if a function name was passed as an argument
if [ -z "$1" ]; then
    echo "No function name provided. Using default function name."
    FUNCTION_NAME=$DEFAULT_FUNCTION_NAME
else
    FUNCTION_NAME=$1  # Set the function name from the first script argument
fi

# List all functions and filter by name to find the function configuration
FUNCTION_ARN=$(aws lambda list-functions | jq -r --arg FUNCTION_NAME "$FUNCTION_NAME" '.Functions[] | select(.FunctionName == $FUNCTION_NAME) | .FunctionArn')

if [ -z "$FUNCTION_ARN" ]; then
    echo "Function with name '$FUNCTION_NAME' not found."
    exit 1
else
    aws lambda get-function-configuration --function-name $FUNCTION_ARN
fi
