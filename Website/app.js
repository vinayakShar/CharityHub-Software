if (process.env.NODE_ENV !== 'production') {
  require('dotenv').config();
}

// Modules are defined here
var express = require('express');
var app = express();
const portNum = 5432;
var path = require('path');
var bodyParser = require('body-parser');
var createUserRoute = require('./routes/createUser');
const passport = require('passport');
const flash = require('express-flash');
const session = require('express-session');
const methodOverride = require('method-override');
const initializePassport = require('./routes/loginUser/passport-config');
const renderHomepage = require('./routes/getCharities');
const updateProfile = require('./routes/editProfile');
const createChar = require('./routes/createCharity');
const renderCharity = require('./routes/getCharity');
const renderHistory = require('./routes/getHistory');
const renderSearch = require('./routes/getSearch');
const renderCalendar = require('./routes/getCalendar');
const createEve = require('./routes/createEvent');
const { render } = require('ejs');
const url = require('url');
const bcrypt = require('bcrypt');
const updatePayment = require('./routes/updatePayment')
initializePassport(passport);

// Defining any modules, methods, etc. that the express application can use
app.use(bodyParser.urlencoded({ extended: false }));
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
app.get('/', function (req, res) {
  renderHomepage.loadHomepage(req, res, checkLoggedIn);
});

// About page route
app.get('/about', (req, res) => {
  res.render('pages/about.ejs', {
    loggedIn: checkLoggedIn(req),
    user: req.user
  });
});

// Add charity route
app.get('/add-charity', (req, res) => {
  res.render('pages/add-charity.ejs', {
    loggedIn: checkLoggedIn(req),
    user: req.user
  });
});

// Create charity
app.post('/add-charity', (req, res) => {
  createChar(req);
  res.redirect('/add-charity')
})

// View charity route
app.get('/view-charity', (req, res) => {
  renderCharity.loadCharity(req, res, url, checkLoggedIn);
})

// View profile
app.get('/profile', (req, res) => {
  res.render('pages/profile.ejs', {
    loggedIn: checkLoggedIn(req),
    user: req.user
  })
})

// Update profile
app.post('/profile', async (req, res) => {
  await updateProfile(req);
  res.redirect('/profile')
})


// Donation history
app.get('/history', (req, res) => {
  renderHistory.loadHistory(req, res, checkLoggedIn);
})


// Add event route
app.get('/add-event', (req, res) => {
  res.render('pages/add-event.ejs', {
    loggedIn: checkLoggedIn(req),
    user: req.user
  });
});

// Create event
app.post('/add-event', (req, res) => {
  createEve(req);
  res.redirect('/add-event')
})

// Search route
app.get('/search', (req, res) => {
  renderSearch.loadSearch(req, res, url, checkLoggedIn);
})

// Calendar route
app.get('/calendar', (req, res) => {
  renderCalendar.loadCalendar(req, res, checkLoggedIn);
})

app.get('/pay', (req, res) => {
  res.render('pages/pay.ejs', {
    loggedIn: checkLoggedIn(req)
  })
})

app.post('/pay', (req, res) => {
  updatePayment(req)

  res.redirect('/')
})

// When user registers, create new user in DB and redirect to home route
app.post('/register', checkNotAuthenticated, function (req, res) {
  createUserRoute.createUser(req, res, bcrypt);
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
  return (req.user ? true : false);
}

// If user is already logged in, redirect them to a page
function checkNotAuthenticated(req, res, next) {
  if (req.isAuthenticated()) {
    return res.redirect('/');
  }

  next();
}

/*
// App to listen to the port
app.listen(portNum, () => {
  console.log(`Example app listening on port ${portNum}!`);
  console.log(`Access local server with this address: http://localhost:${portNum}`);
});
*/

const PORT = process.env.PORT || 8080;

const server = app.listen(PORT, () => {
  console.log(`Express running → PORT ${server.address().port}`);
  console.log(`Link: http://localhost:${server.address().port}`)
});
