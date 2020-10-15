// Modules are defined here
var express = require('express');
var app = express();
const portNum = 8000;
var path = require('path');
var bodyParser = require('body-parser');
var createUserRoute = require('./routes/createUser');

// Allows express to use body-parser and obtain access to all
// files within the public folder (which has the html and css folders
// the front end)
app.use(bodyParser.urlencoded({extended: false}));
app.use(express.static('public'));

// When user gets to home page, send user the register.html page
app.get('/', function(req, res) {
  res.sendFile(path.join(__dirname + '/public/home.html'));
});

// When user gets routed to the '/login' page, send the login.html page
app.get('/login', function(req, res) {
  res.sendFile(path.join(__dirname + '/public/login.html'));
});

// When a user hits submit on register.html, add data from
// the form to the CharityHub database
app.post('/create_user', function(req, res) {
  createUserRoute.createUser(req);
  // While the queries occur asynchronously above, we can redirect the user to the login page
  res.redirect('/login');
  res.end();
});

// This allows our sample.js to listen in on the 
app.listen(portNum, () => {
  console.log(`Example app listening on port ${portNum}!`);
  console.log(`Access local server with this address: http://localhost:${portNum}`);
});