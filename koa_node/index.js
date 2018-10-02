const serverless = require('serverless-http');
const Koa = require('koa');
const koaRouter = require('koa-router');

const app = new Koa();
const router = new koaRouter();
router.get('/', (ctx) => {});

app.use(router.routes()).use(router.allowedMethods());

module.exports.handler = (event, context, callback) => {
  const response = {
    statusCode: 200,
    body: "Hello from Lumigo!"
  };

  callback(null, response);
};