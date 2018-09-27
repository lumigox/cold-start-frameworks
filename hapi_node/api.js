exports.plugin = {
  name: 'lambda',
  version: '1.0.0',
  register: function (server, options) {

    server.route({
      method: 'GET',
      path: '/',
      handler: function (request, h) {}
    });

  }
};