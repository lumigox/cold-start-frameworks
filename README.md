# General
# Requirements & Recomendations
* It's recommended to create an ec2 instance in the same region the Lambda will be created (us-east-1, N. Virginia) and to run the script  
* Serverless is mandatory. Run `npm install -g serverless`
* Make sure AWS access is configured on your machine. Follow `https://docs.aws.amazon.com/cli/latest/userguide/installing.html`
# Running
Right now the repository contains templates for five nodejs frameworks:
1. [Express](http://expressjs.com/)
2. [Hapi](https://hapijs.com/)
3. [Koa](https://koajs.com/)
4. [Lambda API](https://serverless-api.com/)
5. [Restify](http://restify.com/)
5. Plain old nodejs

In order test a framework please run `./test.sh <directory> <memory>` when `directory` is the template directory to run and `memory` is memory assigned to the lambda.


# Creating new template
* Right now the testing framework only supports nodejs projects.
* Each template directory should contain a `serverless_template.yml` file.
* This file contains the basic configuration for the serverless framework and some variables that are being replaced the testing framework. Variables start and end with `@` and right now only `@DATE@` and `@MEMORY@` are supported
Example:
```
service: nodejs-express-@DATE@

provider:
  name: aws
  runtime: nodejs8.10
  stage: dev
  region: us-east-1

functions:
  memory-@MEMORY@:
    handler: index.handler
    memorySize: @MEMORY@
```
* Place the code and relevant configuration in this directory
* You are good to go.