const api = require('lambda-api')()

api.get('/', async (req,res) => {})

module.exports.handler = (event, context, callback) => {
  const response = {
    statusCode: 200
    body: "Hello from Lumigo!"
  };

  callback(null, response);
};