'use strict';

const Koa = require('koa');
const Router = require('koa-router');
const ipFilter = require('ip-filter');
const proxy = require('koa-better-http-proxy');
const bodyParser = require('koa-bodyparser');
const fs = require('fs');
const path = require('path');
const util = require('util');
const http = require('http');
const r2 = require('r2');
const _ = require('lodash');
const Slack = require('./lib/slack_helper');

const readFile = util.promisify(fs.readFile);
const app = new Koa();
const router = new Router();
const slack = new Slack('Felica Punch', ':panda_face:');

const PORT = process.env.PORT || 3030;
const rails_port = 3000;

require('dotenv').config();

// const io = require('socket.io')(app);
app.use(logger);
app.use(filter(process.env.IP_ALLOW));
app.use(async (ctx, next) => {
  if (ctx.path !== '/socket/punch') ctx.disableBodyParser = true;
  await next();
});
app.use(bodyParser());// こいつはrails用のparamsを勝手にjsonにする
app.use(router.routes()).use(router.allowedMethods());
app.use(proxy(`localhost:${rails_port}`, {
  filter: (ctx) => {
    if (ctx.path.includes('socket.io') || ctx.path.includes('/socket/socket.js')) {
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
console.log(`Server listen on ${PORT}`);

io.on('connection', (socket) => {
  socket.emit('connected', 'Server Connected!');
});

router.get('/socket/socket.js', async (ctx) => {
  let socket_js = await readFile(path.join(__dirname, './socket.js'));
  const origin = ctx.origin.replace(/http:|https:/, '');
  // console.log(origin);
  const host = `HOST = '${origin}';`;
  socket_js = socket_js.toString().replace(`HOST = 'http://localhost:3000';`, host);
  ctx.type = 'text/javascript; charset=utf-8';
  ctx.body = socket_js;
});

router.post('/socket/punch', async (ctx) => {
  let { card_uid, card_type } = ctx.request.body;
  const origin = `http://localhost:${rails_port}`;
  console.log(card_uid, card_type);
  
  try {
    if (!card_uid) {
      throw Error('Error! no card_uid');
    }
    const card_info = await r2.get(`${origin}/cards.json?card_uid=${card_uid}`).json;
    const user_name = _.get(card_info, '0.user_name');
    const msg = {
      "card_uid": card_uid,
      "card_type": card_type
    };
    console.log(card_info);
    if (user_name) {
      const res = await r2.post(`${origin}/punch_logs.json`, { json: msg }).json;
      ctx.body = res;
      if (res.slack_url) {
        const raw_url = res.url.replace('.json', '').replace(origin, ctx.origin);
        const text = `<@${res.slack_name}> ${res.user_name} [ ${res.description || res.card_uid} ] Punched at <${raw_url}|${new Date(res.updated_at).toLocaleString()}>`;
        const slack_res = slack.send(res.slack_url, res.slack_room_id, text); // 非同期でSlackに通知
      }
      // ctx.body = res;
    } else {
      io.emit('card_info', msg);
      // ctx.body = 'ok';
      // ctx.status = 200;
      ctx.body = { user_name: 'New Card!', card_uid };
    }
  } catch (e) {
    ctx.body = { error: e.message };
    ctx.status = 421;
  }
});

router.get('/socket/heart_beat', async (ctx, next) => {
  ctx.status = 200;
});

// logger
async function logger(ctx, next) {
  const start = Date.now()
  await next()
  const ms = Date.now() - start
  console.log(`[${new Date(start)}] ${ctx.method} ${ctx.url} - ${ms}ms`)
}

function filter(ipAllow) {
  let ipAllowList = [];
  if (ipAllow) {
    ipAllowList = ipAllow.split(',');
  } else {
    ipAllowList = ['*'];
  }
  ipAllowList = ipAllowList.map(ip => ip.trim()); 
  ipAllowList.push('127.0.0.1')// allows localhost
  let fun = async (ctx, next) => {
    let ip = ctx.ip;
    if (ip === '::1') {
      ip = '127.0.0.1';
    } else {
      ip = ip.match(/\d+.\d+.\d+.\d+/) ? ip.match(/\d+.\d+.\d+.\d+/)[0] : '127.0.0.1';
    }
    const res = ipFilter(ip, ipAllowList, { strict: false });
    // console.log('ipAllowList', ipAllowList);
    // console.log('ip', ip);
    // console.log('ipFilter', res);
    if (res) {
      await next();
    } else {
      ctx.body = {error: `Your IP: ${ip} Not Allowed`};
      ctx.status = 403;
    }
  };
  return fun;
}