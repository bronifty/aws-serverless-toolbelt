import { exec } from "child_process";
import util from "util";

const execAsync = util.promisify(exec);

/**
 * Generic function to get AWS resource ARN by name.
 * @param {string} resourceType - Type of the resource ('api' or 'lambda').
 * @param {string} subCommand - Command to use to fetch the resource.
 * @param {string} resourceName - Name of the resource.
 * @returns {Promise<string>} - A promise that resolves to the ARN of the resource.
 */

async function getResourceArn(
  resourceType: "lambda" | "apigatewayv2",
  resourceName: string,
  subCommand?: string
) {
  let command;
  let resourceTypeVariable;
  switch (resourceType) {
    case "apigatewayv2":
      resourceTypeVariable = "API_NAME";
      if (!subCommand) {
        subCommand = "get-apis";
      }
      break;
    case "lambda":
      resourceTypeVariable = "FUNCTION_NAME";
      if (!subCommand) {
        subCommand = "list-functions";
      }
      break;
    default:
      throw new Error('Unsupported resource type. Use "api" or "lambda".');
  }

  if (resourceType === "apigatewayv2") {
    // Updated command to fetch the ARN for API Gateway
    command = `aws ${resourceType} ${subCommand} | jq -r --arg ${resourceTypeVariable} "${resourceName}" '.Items[] | select(.Name == $API_NAME) | .Arn'`;
  } else if (resourceType === "lambda") {
    // Command to fetch the ARN for Lambda functions
    command = `aws ${resourceType} ${subCommand} | jq -r --arg ${resourceTypeVariable} "${resourceName}" '.Functions[] | select(.FunctionName == $FUNCTION_NAME) | .FunctionArn'`;
  } else {
    throw new Error('Unsupported resource type. Use "api" or "lambda".');
  }

  try {
    const { stdout, stderr } = await execAsync(command);
    if (stderr) {
      throw new Error(`Error fetching data: ${stderr}`);
    }
    return stdout.trim();
  } catch (error) {
    console.error(`Failed to execute command: ${error}`);
    throw error;
  }
}

// Example usage:
getResourceArn("lambda", "function")
  .then((arn) => console.log("Lambda ARN:", arn))
  .catch((err) => console.error(err));

getResourceArn("apigatewayv2", "api")
  .then((apiArn) => console.log("API ARN:", apiArn))
  .catch((err) => console.error(err));

//   {
//     "Items": [
//         {
//             "ApiEndpoint": "https://l4bykgc6k6.execute-api.us-east-1.amazonaws.com",
//             "ApiId": "l4bykgc6k6",
//             "ApiKeySelectionExpression": "$request.header.x-api-key",
//             "CreatedDate": "2024-05-31T02:43:57+00:00",
//             "DisableExecuteApiEndpoint": false,
//             "Name": "api",
//             "ProtocolType": "HTTP",
//             "RouteSelectionExpression": "$request.method $request.path",
//             "Tags": {}
//         }
//     ]
// }

//   API_ID=$(aws apigatewayv2 get-apis | jq -r --arg API_NAME "$API_NAME" '.Items[] | select(.Name == $API_NAME) | .ApiId')

// if [ -z "$API_ID" ]; then
//     echo "API with name '$API_NAME' not found."
//     exit 1
// else
//     # Construct the ARN for the API
//     REGION=$(aws configure get region)
//     ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
//     API_ARN="arn:aws:apigateway:$REGION::$ACCOUNT_ID:/apis/$API_ID"

//     # Use the ARN to get the API details
//     echo "Fetching details for API ARN: $API_ARN"
//     aws apigatewayv2 get-api --api-id $API_ID
// fi

// --------------------------------

// aws apigatewayv2 get-apis --query 'Items[*].ApiEndpoint'

// {
//   "Items": [
//       {
//           "ApiEndpoint": "https://l4bykgc6k6.execute-api.us-east-1.amazonaws.com",
//           "ApiId": "l4bykgc6k6",
//           "ApiKeySelectionExpression": "$request.header.x-api-key",
//           "CreatedDate": "2024-05-31T02:43:57+00:00",
//           "DisableExecuteApiEndpoint": false,
//           "Name": "api",
//           "ProtocolType": "HTTP",
//           "RouteSelectionExpression": "$request.method $request.path",
//           "Tags": {}
//       }
//   ]
// }

// --------------------------------
// {
//   "Functions": [
//       {
//           "FunctionName": "function",
//           "FunctionArn": "arn:aws:lambda:us-east-1:851725517932:function:function",
//           "Runtime": "nodejs20.x",
//           "Role": "arn:aws:iam::851725517932:role/lambda-full-access",
//           "Handler": "index.handler",
//           "CodeSize": 3327808,
//           "Description": "",
//           "Timeout": 3,
//           "MemorySize": 128,
//           "LastModified": "2024-06-01T03:58:53.971+0000",
//           "CodeSha256": "tulU60LvHUsDyid6TjB1Q8rg9lR+b9YMVgMgllCv7EI=",
//           "Version": "$LATEST",
//           "TracingConfig": {
//               "Mode": "PassThrough"
//           },
//           "RevisionId": "5c44ac30-8ccb-4a7e-81ba-9b4f8cc8cf26",
//           "PackageType": "Zip",
//           "Architectures": [
//               "x86_64"
//           ],
//           "EphemeralStorage": {
//               "Size": 512
//           },
//           "SnapStart": {
//               "ApplyOn": "None",
//               "OptimizationStatus": "Off"
//           },
//           "LoggingConfig": {
//               "LogFormat": "Text",
//               "LogGroup": "/aws/lambda/function"
//           }
//       }
//   ]
// }
