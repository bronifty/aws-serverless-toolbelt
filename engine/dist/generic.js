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
async function getResourceArn(resourceType, resourceName) {
    let command;
    const REGION = await execAsync("aws configure get region");
    const ACCOUNT_ID = await execAsync("aws sts get-caller-identity --query Account --output text");
    let FUNCTION_NAME;
    let API_ID;
    const FUNCTION_ARN = `arn:aws:lambda:${REGION}:${ACCOUNT_ID}:function:${FUNCTION_NAME}`;
    const API_ARN = `arn:aws:apigateway:${REGION}::${ACCOUNT_ID}:/apis/${API_ID}`;
    switch (resourceType) {
        case "api":
            // get api_id
            command = "aws apigatewayv2 get-apis --query 'Items[*].ApiId'"[0];
            // console.log(API_ID);
            // return API_ARN;
            break;
        case "lambda":
            // get function_name
            command =
                "aws lambda list-functions --query 'Functions[*].FunctionName'"[0];
            // console.log(FUNCTION_NAME);
            // return FUNCTION_ARN;
            break;
        default:
            throw new Error('Unsupported resource type. Use "api" or "lambda".');
    }
    try {
        const { stdout, stderr } = await execAsync(command);
        if (stderr) {
            throw new Error(`Error fetching data: ${stderr}`);
        }
        return stdout.trim();
    }
    catch (error) {
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
// ----------------------------
// REGION=$(aws configure get region)
// ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
//     API_ARN="arn:aws:apigateway:$REGION::$ACCOUNT_ID:/apis/$API_ID"
// ----------------------------
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
// aws lambda list-functions --query 'Functions[*].FunctionName'
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
