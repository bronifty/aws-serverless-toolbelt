#!/bin/bash

# bash variables
# export NATS_SERVER_VERSION="2.10.9"
# export NATS_CLI_VERSION="0.1.3"
# export GOLANG_VERSION="1.22.0"
# export ARCH="$(uname -m)"
export FUNCTION_NAME="function"
export LAMBDA_HANDLER="index.handler"
export LAMBDA_ROLE="arn:aws:iam::851725517932:role/lambda-full-access"
export LAMBDA_LAYERS="arn:aws:lambda:us-east-1:851725517932:layer:fastify-layer:2 arn:aws:lambda:us-east-1:851725517932:layer:fastify-aws-lambda-layer:1"
export LAMBDA_RUNTIME="nodejs20.x"
export HTTP_API_NAME="function-API"
export REGION="us-east-1"
export ACCOUNT_ID="851725517932"
