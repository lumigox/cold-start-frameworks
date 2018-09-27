var restify = require('restify');

const server = restify.createServer({
  name: 'myapp',
  version: '1.0.0'
});

server.use(restify.plugins.acceptParser(server.acceptable));
server.use(restify.plugins.queryParser());
server.use(restify.plugins.bodyParser());

server.get('/echo/:name', function (req, res, next) {});

module.exports.handler = (event, context, callback) => {
  const response = {
    statusCode: 200,
    body: "Hello from Lumigo!"
  };

  callback(null, response);
};
