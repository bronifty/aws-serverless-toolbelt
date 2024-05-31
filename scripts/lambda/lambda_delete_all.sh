#!/bin/bash

# Pipe the output of get_all_lambdas.sh to delete_lambda.sh to delete all Lambda functions
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

"$SCRIPT_DIR/lambda_get_all.sh" | while read function_name; do
  "$SCRIPT_DIR/lambda_delete_one.sh" "$function_name"
  done