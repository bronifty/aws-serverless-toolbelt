#!/bin/bash

# List all Lambda functions by name
aws lambda list-functions --query 'Functions[*].FunctionName' --output text