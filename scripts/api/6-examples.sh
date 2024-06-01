# Create API
aws apigatewayv2 create-api --name 'MyAPI' --protocol-type 'HTTP' --target arn:aws:lambda:us-east-1:123456789012:function:myFunction

# Create Integration
aws apigatewayv2 create-integration --api-id a1b2c3d4 --integration-type AWS_PROXY --integration-method POST --integration-uri arn:aws:lambda:us-east-1:123456789012:function:myFunction

# Create Route
aws apigatewayv2 create-route --api-id a1b2c3d4 --route-key 'GET /todos' --target integrations/9876xyz

# Deploy API
aws apigatewayv2 create-deployment --api-id a1b2c3d4 --stage-name dev

# Add Permission
aws lambda add-permission --function-name myFunction --statement-id apigateway-test --action lambda:InvokeFunction --principal apigateway.amazonaws.com --source-arn arn:aws:execute-api:us-east-1:123456789012:a1b2c3d4/*/*/*