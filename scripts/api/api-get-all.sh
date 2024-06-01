#!/bin/bash
# aws apigatewayv2 get-apis | jq -r '.Items[] | .ApiId'
aws apigatewayv2 get-apis 