# AWS Serverless Toolbelt

- The main goal is to deploy ssr apps like remix, vite, vike, next, etc
- The orientation of the goal is from aws cli and work our way toward the cdk and then finally integrate into winglang
- This repo is based on a combination of different repos, namely one by vinny for express with an apigateway trigger via console; another based on the default sam hello world app with a test apigateway event sent to a lambda shaped request reply handler which also includes a nice typescript config and a test setup; and finally there is some stuff in here in the reference folder from the vercel remix plugin for vite as well as my own material in the makefile and scripts for sys admin stuff.
- What I would like to do is be able to get at any part of the serverless resources like lambda and apigatewayv2, cloudfront cdn and s3, even dynamodb and sqs and eventbridge, as well as step functions, perhaps some other stuff but those are the main ones. I want to have a system that puts these pieces together according to a formula, and then i want to incrementally incorporate those steps from cli into cdk and then finally bring some custom resources into winglang as libraries where they can be put to use in app products.
- Along the way I can imagine this or some derivative of it could become some kind of toolbelt and dev tool for creating serverless apps and monitoring them. The cli is one tool, sdk is another; requests could be made from a react dashboard to get all the resources listed and have a multitentant app to manage those resources.

.

# How to create a serverless express app:

## Important thing to know:

- Make sure you have your index.js file in the root of your projects directory. If this isn't here the Lambda function will throw an error.
- Make sure you don't use the base route in your express server. HTTP requests to this base route will not be sent to our proxy Lambda.

### Example:

#### Will not work

http://supercoolapigatewayurl.com/stageName

#### Will work

http://supercoolapigatewayurl.com/stageName/todos

## Create Lambda function and API Gateway

1. First create your lambda function. You can upload this code by selecting the content of directory and compressing it. Lambda allows you to take this zip file and upload it.
   <img width="500" alt="image" src="https://user-images.githubusercontent.com/49013231/206956927-e444d463-4138-487f-bce5-d5b9117daeae.png">

2. Now you can create your API Gateway. I used the Rest API for this but I'm sure HTTP API would work as well.

3. You need to add a resource on your API Gateway on the root path. Be sure to check the boxes for configure as proxy resource and enable API Gateway CORS. Then you need to link this resource to the lambda function that we created earlier.
   <img width="900" alt="image" src="https://user-images.githubusercontent.com/49013231/206956849-6aaa5844-17c9-4d69-9213-7408c259c2c7.png">
   <img width="900" alt="image" src="https://user-images.githubusercontent.com/49013231/206956880-14b1ecd5-2052-4b8c-b2f3-3413ec2510b9.png">

4. Now that we finished creating all of our API Gateway changes we need to go and deploy the API so we can test it.
   <img width="500" alt="image" src="https://user-images.githubusercontent.com/49013231/206956693-e1685897-72b4-42e5-a563-2959d418c4de.png">
