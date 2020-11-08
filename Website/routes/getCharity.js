const db = require('../db/access');

// Obtains charity names and info about them, then
// returns that info to the homepage to render
function getCharityInfo(req, res, url, checkLoggedIn) 
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

    const charityID = url.parse(req.url, true).query;

    var getEventsQuery = `SELECT * FROM event WHERE org_id = '${charityID.id}' ORDER BY event_date LIMIT 3;`;

    db.query(charityInfoQuery)
    .then(data => {
        console.log(data.rows);
        // res.render('pages/view-charity.ejs', {
        //     loggedIn: checkLoggedIn(req),
        //     failLoggedInMessage: req.flash('error'),
        //     charities: data.rows
        // });
        db.query(getEventsQuery)
        .then(eventData => {
            console.log(eventData);
            res.render('pages/view-charity.ejs', {
                loggedIn: checkLoggedIn(req),
                failLoggedInMessage: req.flash('error'),
                charities: data.rows,
                events: eventData.rows
            });
        })
        .catch(err => {
            console.log(err);
            res.status(500).send("Error code 500: Internal server error");
        })
    })
    .catch(err => {
        console.log(err);
        res.status(500).send("Error code 500: Internal server error");
    })
}

module.exports = {
    loadCharity: (req, res, url, checkLoggedIn) => { getCharityInfo(req, res, url, checkLoggedIn) }
}