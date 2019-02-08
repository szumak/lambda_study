'use strict';
const AWS = require('aws-sdk');
var s3 = new AWS.S3();

var response = {
		"statusCode": 200,
		"headers": {
			'Access-Control-Allow-Origin': '*',
			'Access-Control-Allow-Methods': 'GET',
			'Access-Control-Allow-Credentials': true,
		},
		"isBase64Encoded": false,
};

exports.s3put = function(request, context, callback) {
	let bucket = "msz-test-inbox";
	let key  = "date";
	let date = new Date();
	let content = "Date: " + date;
	var params  = {
			Bucket : bucket,
			Key    : key,
			Body   : content
	};
	s3.putObject(params, function(err, data) {
		if (err) console.log(err, err.stack); // an error occurred
		else     console.log(data);           // successful response
	});
	response.body = "s3 object created";
  callback(null, response);
};
