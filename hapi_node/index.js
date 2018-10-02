const hapiLambda = require('hapi-lambda-proxy');
const api = require('./api');

hapiLambda.configure([api]);

module.exports.handler = (event, context, callback) => {
  const response = {
    statusCode: 200,
    body: "Hello from Lumigo!"
  };

  callback(null, response);
};