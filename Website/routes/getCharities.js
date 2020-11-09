const db = require('../db/hero');

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
        org_details.org_id = org_account.org_id;`;

    var getEventsQuery = `SELECT * FROM event WHERE event_date >= CURRENT_DATE ORDER BY event_date LIMIT 10;`;

    db.query(charityInfoQuery)
    .then(data => {
        console.log(data.rows);
        // res.render('pages/home.ejs', {
        //     loggedIn: checkLoggedIn(req),
        //     failLoggedInMessage: req.flash('error'),
        //     charities: data.rows
        // });
        db.query(getEventsQuery)
        .then(eventData => {
            console.log(eventData);
            res.render('pages/home.ejs', {
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
    loadHomepage: (req, res, checkLoggedIn) => { getCharityInfo(req, res, checkLoggedIn) }
}