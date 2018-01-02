'use strict';

const Koa = require('koa');
const Router = require('koa-router');
const proxy = require('koa-better-http-proxy');
const fs = require('fs');
const path = require('path');
const util = require('util');
const http = require('http');
const readFile = util.promisify(fs.readFile);

const app = new Koa();
const router = new Router();

const PORT = process.env.PORT || 3030;

// const io = require('socket.io')(app);
app.use(router.routes()).use(router.allowedMethods());
app.use(proxy('localhost:3000', {
  filter: (ctx) => {
    // return true;
    console.log(ctx.path);
    console.log(ctx.path.includes('socket.io'));
    if (ctx.path.includes('socket.io')) {
      return false;
    } else {
      const origin = ctx.origin.replace(/http:|https:/, '');
      ctx.headers['X-Forwarded-Host'] = origin;
      return true;
    }
  }
}));

// app.listen(3030);
const server = http.createServer(app.callback())
const io = require('socket.io')(server);
server.listen(PORT);

io.on('connection', (socket) => {
  socket.emit('popo', { po: 'poppopopo' });
});

router.get('/socket/socket.js', async (ctx) => {
  let socket_js = await readFile(path.join(__dirname, './socket.js'));
  const origin = ctx.origin.replace(/http:|https:/, '');
  const host = `const HOST = '${origin}';`;
  socket_js = socket_js.toString().replace(`const HOST = 'http://localhost:3000';`, host);
  ctx.type = 'text/javascript; charset=utf-8';
  ctx.body = socket_js;
});