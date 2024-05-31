#!/bin/bash

# List all function functions by name
aws lambda list-functions --query 'Functions[*].FunctionName' --output text