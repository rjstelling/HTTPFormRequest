/* server.js
 *
 * Run:
 * $ node server.js
 *
 * Visit:
 * http://localhost:1973
 */

var express = require('express');
var app = express()

var http = require('http').Server(app);
var multer = require('multer')

var upload = multer()

app.post('/httpformrequest-test-000', upload.array(), function (req, res, next) {
	
	// req.body contains the text fields
	console.log("Test value:" + req.body.TEST);
	res.sendStatus(200);
})

http.listen(1973, function(){
  console.log('Listening on *:1973');
});