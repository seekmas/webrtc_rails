var express = require('express');
var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

// usernames which are currently connected to the chat
var usernames = {};
var numUsers = 0;
//io.set('origins', '*:*');



io.on('connection' , function(socket){

	socket.emit('welcome' , 'Welcome to socket')

	socket.on('join' , function(user){
		var new_user = {'name': user.name , 'position': user.position};

		usernames[socket.id] = new_user;

		++numUsers;
	});

	socket.on('disconnect', function () {
		// remove the username from global usernames list
		if (usernames[socket.id]) {
			var name = usernames[socket.id];
			delete usernames[socket.id];
			--numUsers;
			// echo globally that this client has left
			socket.broadcast.emit('disconnect', {
				username: name,
				numUsers: numUsers
			});

			io.emit('list users' , usernames);
		}
	});

	socket.on('list users' , function(){
		io.emit('list users' , usernames);
	});

	socket.on('count users' , function(){
		io.emit('count users' , numUsers);
	});

	socket.on('typing' , function(data){
		io.emit('typing' , data);
	});

});

http.listen('12138' , function(){
	console.log('server start at : 0.0.0.0:12138');
});