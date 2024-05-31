#!/bin/bash

# bash variables
# export NATS_SERVER_VERSION="2.10.9"
# export NATS_CLI_VERSION="0.1.3"
# export GOLANG_VERSION="1.22.0"
# export ARCH="$(uname -m)"
export DEFAULT_FUNCTION_NAME="function"
export DEFAULT_API_NAME="api"
export DEFAULT_function_HANDLER="index.handler"
export function_ROLE="arn:aws:iam::851725517932:role/function-full-access"
export function_LAYERS="arn:aws:function:us-east-1:851725517932:layer:fastify-layer:2 arn:aws:function:us-east-1:851725517932:layer:fastify-aws-function-layer:1"
export function_RUNTIME="nodejs20.x"
export REGION="us-east-1"
export ACCOUNT_ID="851725517932"
