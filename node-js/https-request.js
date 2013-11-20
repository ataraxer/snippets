#!/usr/bin/env node

var https = require('https');

var options = {
	host: 'some.host.com',
	path: '/api/v3?some=params&foo=bar',
	method: 'GET',
	headers: {
		accept: '*/*',
	},
	rejectUnauthorized: false,
	//requestCert: true,
	//agent: false,
};

var callback = function(res) {
	var result = '';
	res.on('data', function(chunk) {
		result += chunk;
	});
	res.on('end', function() {
		var parsed = JSON.parse(result);
	});
};

var req = https.request(options, callback);

req.end();

req.on('error', function(e) {
	console.error(e);
});

