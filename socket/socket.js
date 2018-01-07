// 'use strict';

var HOST = 'http://localhost:3000';
var socket = io(HOST);
socket.on('connected', (data) => {
  console.log(data);
});

socket.on('card_info', (data) => {
  console.log(data);
  document.querySelector('#card_card_uid').value = data.card_uid;
  document.querySelector('#card_card_type').value = data.card_type;
});