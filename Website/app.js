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

const db = require('./db/hero');
const paypal = require('paypal-rest-SDK');

const cookieParser = require('cookie-parser');


initializePassport(passport);

// Defining any modules, methods, etc. that the express application can use
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json()); // support json encoded bodies
app.use(cookieParser());
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

//                                --PAYPAL--
//Config PayPal API
paypal.configure({
  'mode': 'sandbox', //sandbox or live .... but <KEEP IT SANDBOX>
  'client_id': 'AVLFER1_iqqqxfqEoLU_U5wv2hp7SLxW4vhruXF2mtZZ2CwHMBu1Yo0XoICFTBDSS_bVzRtV9kq0t2eD',
  'client_secret': 'EA6G3I29nUiNtvw43P_nyWl3hY6gzJjKkmRm0sOWbzTYP16dPwLyT7HXFKBICOP1-zSbY6LONRlyMzNK'
});


//Create Payment
app.post('/pay', (req, res) => {
  const money = parseInt(req.body.donation, 10);
  const currUser = req.user.account_id;

  function getOrgName() {
    db.query(`SELECT org_account.name FROM public.org_account WHERE org_account.org_id = '${req.cookies.charInst}';`)
    .then(response => {
      const payTo = response;
      return payTo;
    })
    .catch(error => {
        console.log(error);
    })
  }


  const payTo = req.cookies.charInst;

  const create_payment_json = {
    "intent": "sale",
    "payer": {
        "payment_method": "paypal"
    },
    "redirect_urls": {
        "return_url": "/success",
        "cancel_url": "/cancel"
    },
    "transactions": [{
        "item_list": {
            "items": [{
                "name": "Donation",
                "price": JSON.stringify(money),
                "currency": "USD",
                "quantity": 1
            }]
        },
        "amount": {
            "currency": "USD",
            "total": JSON.stringify(money)
        },
        "description": 'Donation to ' + JSON.stringify(payTo)
    }]
};

paypal.payment.create(create_payment_json, function (error, payment) {
    if (error) {
        throw error;
    } else {
        for(let i=0; i < payment.links.length; i++) {
          if (payment.links[i].rel === 'approval_url'){
            res.redirect(payment.links[i].href);
          }
        }
    }
});

});


//Execute Payment
app.get('/success', (req, res) => {

  const donorId = req.query.PayerID;
  const paymentId = req.query.paymentId;

  const execute_payment_json = {
    "payer_id": donorId,
  //  "transactions": [{
    //    "amount": {
      //      "currency": "USD",
        //    "total": JSON.stringify(exeAmount)
        //}
    //}]
  };

  paypal.payment.execute(paymentId, execute_payment_json, function (error, payment) {
      if (error) {
          console.log(error.response);
          throw error;
      } else {
          console.log(JSON.stringify(payment));
          const amount = payment.transactions[0].amount.total;
          const type = payment.payer.payment_method;
          const transaction_id = payment.id;
          const unique_payer = payment.payer.payer_info.payer_id;
          const payment_id = req.cookies.charInst;
          const account_id = req.user.account_id;

          db.query(`INSERT INTO public.payment(transaction_id, unique_payer, payment_id, account_id, amount, payment_date, type)
          VALUES('${transaction_id}', '${unique_payer}', ${payment_id}, 2, ${amount}, now(), '${type}');`);
          res.redirect('/');
      }
  });
  });

app.get('/cancel', (req,res) => res.send('Canceled'));

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
