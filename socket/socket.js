'use strict';

const HOST = 'http://localhost:3000';
const socket = io(HOST);
socket.on('popo', (data) => {
  console.log(data);
});