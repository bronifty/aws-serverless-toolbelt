import { exec } from "child_process";
import util from "util";

const execAsync = util.promisify(exec);

/**
 * Generic function to get AWS resource ARN or ID by name.
 * @param {string} resourceType - Type of the resource ('api' or 'lambda').
 * @param {string} resourceName - Name of the resource.
 * @returns {Promise<string>} - A promise that resolves to the ARN or ID of the resource.
 */
async function getResourceArnOrId(
  resourceType: "api" | "lambda",
  resourceName: string
) {
  let command;

  if (resourceType === "api") {
    command = `aws apigatewayv2 get-apis | jq -r --arg API_NAME "${resourceName}" '.Items[] | select(.Name == $API_NAME) | .ApiId'`;
  } else if (resourceType === "lambda") {
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
getResourceArnOrId("lambda", "function")
  .then((arn) => console.log("Lambda ARN:", arn))
  .catch((err) => console.error(err));

getResourceArnOrId("api", "api")
  .then((apiId) => console.log("API ID:", apiId))
  .catch((err) => console.error(err));
