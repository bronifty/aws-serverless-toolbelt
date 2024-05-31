#!/bin/bash

# Delete a Lambda function given its name
function_name=$1
aws lambda delete-function --function-name "$function_name"