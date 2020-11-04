if(process.env.NODE_ENV !== 'production') {
  require('dotenv').config();
}

// Modules are defined here
var express = require('express');
var app = express();
const portNum = 8000;
var path = require('path');
var bodyParser = require('body-parser');
var createUserRoute = require('./routes/createUser');
const passport = require('passport');
const flash = require('express-flash');
const session = require('express-session');
const methodOverride = require('method-override');
const initializePassport = require('./routes/loginUser/passport-config');
const renderHomepage = require('./routes/getCharities');
const { render } = require('ejs');
initializePassport(passport);

// Defining any modules, methods, etc. that the express application can use
app.use(bodyParser.urlencoded({extended: false}));
app.use(express.static('public'));
app.use(session({
  secret: process.env.SESSION_SECRET,
  resave: false,
  saveUninitialized: false
}));
app.use(passport.initialize());
app.use(passport.session());
app.use(methodOverride('_method'));
app.use(flash());

// Tell express to render files in EJS
app.set('view-engine', 'ejs');

// Home page route
app.get('/', function(req, res) {
  renderHomepage.loadHomepage(req, res, checkLoggedIn);
});

// About page route
app.get('/about', (req, res) => {
  res.render('pages/about.ejs', {
    loggedIn: checkLoggedIn(req)
  });
});

// Add charity route
app.get('/add-charity', (req, res) => {
  res.render('pages/add-charity.ejs', {
    loggedIn: checkLoggedIn(req)
  });
});

// View charity route
app.get('/view-charity', (req, res) => {
  res.render('pages/view-charity.ejs', {
    loggedIn: checkLoggedIn(req)
  });
})

// When user registers, create new user in DB and redirect to home route
app.post('/register', checkNotAuthenticated, function(req, res) {
  createUserRoute.createUser(req, res);
});

// Uses passport module to login user
app.post('/login_user', checkNotAuthenticated, passport.authenticate('local', {
  successRedirect: '/',
  failureRedirect: '/',
  failureFlash: true
}));

// Logout user
app.delete('/logout_user', (req, res) => {
  req.logOut();
  res.redirect('/');
});

// If user logged in, return true
// This is used by ejs files to change page based on if user is logged in or not
function checkLoggedIn(req) {
  if(req.user) {
    return true;
  }

  return false;
}

// If user is already logged in, redirect them to a page
function checkNotAuthenticated(req, res, next) {
  if(req.isAuthenticated()) {
    return res.redirect('/');
  }

  next();
}

// App to listen to the port
app.listen(portNum, () => {
  console.log(`Example app listening on port ${portNum}!`);
  console.log(`Access local server with this address: http://localhost:${portNum}`);
});