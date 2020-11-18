const db = require('../db/hero');

module.exports = (req) => {
    let column = '', value = ''

    if (req.body.firstname) {
        column = 'first_name'
        value = req.body.firstname
    }
    else if (req.body.lastname) {
        column = 'last_name'
        value = req.body.lastname
    }
    else if (req.body.username) {
        column = 'username'
        value = req.body.username
    }
    else if (req.body.email) {
        column = 'email'
        value = req.body.email
    }
    else if (req.body.password) {
        // the change password field is unfinished... I can work on this later if necessary. -Phil
        column = 'password'
        value = req.body.password
    }

    // update information
    db.query(`update user_account set ${column} = '${value}' where account_id = ${req.user.account_id};`)

    // update 'last_update"
    db.query(`update user_account set last_update = to_timestamp(${Date.now()} / 1000) where account_id = ${req.user.account_id};`)
}