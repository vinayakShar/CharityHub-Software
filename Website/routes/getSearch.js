const db = require('../db/hero');

function getCharityInfo(req, res, url, checkLoggedIn) 
{
    const search = url.parse(req.url, true).query;

    if (search.page) {
        var offset = search.page * 6;
    }
    else{
        var offset = 0;
    }

    const charityInfoQuery = 
    `SELECT
        org_account.name, org_details.*
    FROM
        org_account, org_details
    WHERE
        org_details.org_id = org_account.org_id
    AND
        (org_details.type1 ~* '${search.term}'
    OR
        org_details.type2 ~* '${search.term}'
    OR
        org_details.type3 ~* '${search.term}'
    OR
        org_account.name ~* '${search.term}'
    OR
        org_details.tag ~* '${search.term}'
    OR
        org_details.mission ~* '${search.term}')
    LIMIT 7
    OFFSET ${offset};`;

    db.query(charityInfoQuery)
    .then(data => {
        res.render('pages/search.ejs', {
            loggedIn: checkLoggedIn(req),
            failLoggedInMessage: req.flash('error'),
            charities: data.rows,
            term: search.term,
            page: search.page,
            user: req.user
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