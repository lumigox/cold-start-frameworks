// Initialize relevant packages, but do not use it
const serverless = require('serverless-http');
const express = require('express')
const app = express()

app.get('/', function (req, res) {})

serverless(app);

module.exports.handler = (event, context, callback) => {
  const response = {
    statusCode: 200,
    body: "Hello from Lumigo!"
  };

  callback(null, response);
};
