const db = require('../db/access');

// Obtains charity names and info about them, then
// returns that info to the homepage to render
function getCharityInfo(req, res, checkLoggedIn) 
{
    // Change `LIMIT 9` to different value if you want the frontend
    // to have access to more charities
    const charityInfoQuery = 
    `SELECT
        org_account.name, org_details.*
    FROM
        org_account, org_details
    WHERE
        org_details.org_id = org_account.org_id
    LIMIT 9;`;

    db.query(charityInfoQuery)
    .then(data => {
        console.log(data.rows);
        res.render('pages/home.ejs', {
            loggedIn: checkLoggedIn(req),
            failLoggedInMessage: req.flash('error'),
            charities: data.rows
        });
    })
    .catch(err => {
        console.log(err);
        res.status(500).send("Error code 500: Internal server error");
    })
}

module.exports = {
    loadHomepage: (req, res, checkLoggedIn) => { getCharityInfo(req, res, checkLoggedIn) }
}