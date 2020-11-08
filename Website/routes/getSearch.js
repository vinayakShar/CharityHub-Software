const db = require('../db/access');

// Obtains charity names and info about them, then
// returns that info to the homepage to render
function getCharityInfo(req, res, url, checkLoggedIn) 
{
    const search = url.parse(req.url, true).query;

    // Change `LIMIT 9` to different value if you want the frontend
    // to have access to more charities
    const charityInfoQuery = 
    `SELECT
        org_account.name, org_details.*
    FROM
        org_account, org_details
    WHERE
        org_details.org_id = org_account.org_id
    AND
        (org_details.type1 = '${search.term}'
    OR
        org_details.type2 = '${search.term}'
    OR
        org_details.type3 = '${search.term}')
    LIMIT 9;`;

    db.query(charityInfoQuery)
    .then(data => {
        console.log(data.rows);
        res.render('pages/search.ejs', {
            loggedIn: checkLoggedIn(req),
            failLoggedInMessage: req.flash('error'),
            charities: data.rows,
            term: search.term
        });
    })
    .catch(err => {
        console.log(err);
        res.status(500).send("Error code 500: Internal server error");
    })
}

module.exports = {
    loadSearch: (req, res, url, checkLoggedIn) => { getCharityInfo(req, res, url, checkLoggedIn) }
}