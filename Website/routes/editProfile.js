const db = require('../db/hero');
const fetch = require('node-fetch')

module.exports = async (req) => {
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
        column = 'password'
        value = req.body.password
    }
    else if (req.body.tags) {
        column = 'photo_url'

        const key = '7958caab02b88e42f0df046c97bb261c'
        let tags = req.body.tags
        let url = `https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=${key}&tags=${tags}&privacy_filter=1&safe_search=1&extras=url_sq&page=0&format=json&nojsoncallback=1`

        const res = await fetch(url);
        const json = await res.json();
        value = json.photos.photo[0].url_sq

    }

    // update information
    db.query(`update user_account set ${column} = '${value}' where account_id = ${req.user.account_id};`)

    // update 'last_update"
    db.query(`update user_account set last_update = to_timestamp(${Date.now()} / 1000) where account_id = ${req.user.account_id};`)
}