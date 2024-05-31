#!/bin/bash

# List all function functions by name
aws function list-functions --query 'Functions[*].FunctionName' --output text