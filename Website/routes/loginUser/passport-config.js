const LocalStrategy = require('passport-local').Strategy;
const db = require('../../db/hero');
const bcrypt = require('bcrypt');
// const loginUser = require('./loginUser');

// Authenticates when a user logins to see if that account exists within the DB
function authenticateUser(username, password, done)
{
    // Obtain account

    const findUserQuery = `SELECT * FROM user_account WHERE email = '${username}' LIMIT 1;`;

    db.query(findUserQuery)
    .then(response => {
        if(!response.rows[0])
        {
            return done(null, false, { message: 'Wrong username' });
        } else {
            bcrypt.compare(password, response.rows[0].password)
            .then(res => {
                if(res) {
                    return done(null, response.rows[0])
                }
                return done(null, false, { message: 'Wrong password' });
            })
        }
    })
    .catch(error => {
        console.log(error);
        return done(null, false, { message: 'Internal server error' });
    })
}

function getUserByID(id, done)
{
    const findUserbyIDQuery = `SELECT * FROM user_account WHERE account_id = ${id}`;

    db.query(findUserbyIDQuery)
    .then(response => {
        if(response.rows[0].account_id === id)
        {
            return done(null, response.rows[0]);
        } else {
            return done(null, false);
        }
    })
    .catch(error => {
        console.log(error);
        return done(true, false);
    })
}

function initialize(passport)
{
    passport.use(new LocalStrategy({ usernameField: 'loginEmail', passwordField: 'loginPassword'}, authenticateUser));
    passport.serializeUser((user, done) => done(null, user.account_id));
    passport.deserializeUser((id, done) => getUserByID(id, done));
}

module.exports = initialize