#!/bin/bash
API_NAME="YourApiName"  # Replace YourApiName with the name of your API
aws apigatewayv2 get-apis | jq -r --arg API_NAME "$API_NAME" '.Items[] | select(.Name == $API_NAME) | .ApiId'