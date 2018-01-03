'use strict';

const r2 = require('r2');

class Slack {
  constructor(username = 'Bot', icon_emoji) {
    this.username = username;
    this.icon_emoji = icon_emoji;
  }

  getMsg(text, channel_id) {
    let msg = {
      channel: `#${channel_id}`,
      username: this.username,
      text: text
    };
    if (this.icon_emoji) {
      msg.icon_emoji = this.icon_emoji;
    }
    return msg;
  }

  async send(url, channel_id, text) {
    const msg = this.getMsg(text, channel_id);
    let res = await r2.post(url, { json: msg }).text;
    return res;
  }
}

module.exports = Slack;