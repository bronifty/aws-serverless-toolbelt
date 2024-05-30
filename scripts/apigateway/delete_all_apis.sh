   #!/bin/bash

# pipe the output of api_get_all.sh to this script to delete all APIs
# ./api_get_all.sh | ./delete_all_apis.sh

# This script reads API IDs from stdin and deletes each one
while read API_ID; do
    echo "Deleting API with ID: $API_ID"
    aws apigatewayv2 delete-api --api-id $API_ID
done