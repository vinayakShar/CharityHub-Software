const db = require('../db/hero');
const dateObj = new Date();

// Obtains the current date, formatted correctly to insert into DB
function createDate() 
{
    const day = ("0" + dateObj.getDate()).slice(-2);
    const month = ("0" + (dateObj.getMonth() + 1)).slice(-2);
    const year = dateObj.getFullYear();
    const createDate = year + "-" + month +  "-" + day;
    return createDate;
}

// Obtains current time without timezone, formatted correctly to insert into DB
function createTimestamp()
{
    return dateObj.getHours() + ":" + dateObj.getMinutes() + ":" + dateObj.getSeconds();
}

// Creates the new account ID for the new user
function createAccountID(response) {
    // If the response returns an undefined row, that means the user_table is empty
    // so give the first user an account_id of 1 (they are the first registered user in the DB)
    if(response.rows[0] === undefined)
    {
        return 1;
    // Else just return the previous account's ID and add 1 to create the new account ID
    } else {
        return response.rows[0].account_id + 1;
    }
}

// When a user hits submit on register.html, add data from
// the form to create a new user on the CharityHub database
function createUser(request)
{
    console.log("Attempting to create new user...");
    const email = request.body.email;
    const password = request.body.password;
    const creationDate = createDate();
    const creationTimestamp = createTimestamp();
    const fullTimestamp = creationDate + " " + creationTimestamp;
    const selectIDQuery = `SELECT * FROM user_account ORDER BY account_id DESC LIMIT 1`;
    const insertTypes = `(account_id, first_name, last_name, email, address_id, create_date, last_update, active, password, username)`;

    // Select the most recent entry in the DB, then create a new account number and insert into the user_account table
    db.query(selectIDQuery)
    .then(response => {
        const newAccountID = createAccountID(response);
        const insertQuery = `INSERT INTO user_account${insertTypes} VALUES (${newAccountID}, 'NA', 'NA', '${email}', 0, '${creationDate}', '${fullTimestamp}', 1, '${password}', 'NA');`;
        db.query(insertQuery, (error, response) => {
            if(error) {
                throw error;
            }
            console.log("Insert successful! Check PGAdmin for new row entry.");
        });
    })
    .catch(error => console.log(error));
}

// Checks if there is a user that already exists with the same email
function checkUserExists(request, response, createUserCallback)
{
    const email = request.body.email;
    const checkExistsQuery = `SELECT EXISTS(SELECT * FROM user_account WHERE email = '${email}')`;

    db.query(checkExistsQuery)
    .then(res => {
        if(res.rows[0].exists)
        {
            request.flash('error', 'There is a user with that email that already exists');
            response.redirect('/');
            response.end();
        } else {
            createUserCallback(request);
            response.redirect('/');
            response.end();
        }
    })
    .catch(err => {
        console.log(err);
        request.flash('error', 'Internal server error');
        response.redirect('/');
        response.end();
    })
}

module.exports = {
    createUser: (request, response) => { checkUserExists(request, response, createUser) }
}