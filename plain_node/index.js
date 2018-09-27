module.exports.handler = (event, context, callback) => {
  const response = {
    statusCode: 200,
    body: "Hello from Lumigo!"
  };

  callback(null, response);
};
