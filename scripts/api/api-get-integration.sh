#!/bin/bash

# Usage: ./lookup-integration.sh <API_ID> <REGION>

API_ID=$1
REGION=$2

# Fetch all integrations and filter to get the integration ID
aws apigatewayv2 get-integrations --api-id $API_ID --region $REGION | jq -r '.Items[] | .IntegrationId'