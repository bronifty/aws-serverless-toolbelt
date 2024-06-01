import { exec } from "child_process";
import util from "util";

const execAsync = util.promisify(exec);

/**
 * Generic function to get AWS resource ARN by name.
 * @param {string} resourceType - Type of the resource ('api' or 'lambda').
 * @param {string} resourceCommand - Command to use to fetch the resource.
 * @param {string} resourceName - Name of the resource.
 * @returns {Promise<string>} - A promise that resolves to the ARN of the resource.
 */

async function getResourceArn(
  resourceType: "api" | "lambda",
  resourceCommand: string,
  resourceName: string
) {
  let command;
  let resourceTypeVariable;
  switch (resourceType) {
    case "api":
      resourceTypeVariable = "API_NAME";
      break;
    case "lambda":
      resourceTypeVariable = "FUNCTION_NAME";
      break;
    default:
      throw new Error('Unsupported resource type. Use "api" or "lambda".');
  }

  command = `aws ${resourceType} ${resourceCommand} | jq -r --arg ${resourceTypeVariable} "${resourceName}" '.Items[] | select(.Name == $API_NAME) | .Arn'`;

  if (resourceType === "api") {
    // Updated command to fetch the ARN for API Gateway
    command = `aws apigatewayv2 get-apis | jq -r --arg API_NAME "${resourceName}" '.Items[] | select(.Name == $API_NAME) | .Arn'`;
  } else if (resourceType === "lambda") {
    // Command to fetch the ARN for Lambda functions
    command = `aws lambda list-functions | jq -r --arg FUNCTION_NAME "${resourceName}" '.Functions[] | select(.FunctionName == $FUNCTION_NAME) | .FunctionArn'`;
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

getResourceArn("api", "api")
  .then((apiArn) => console.log("API ARN:", apiArn))
  .catch((err) => console.error(err));

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
