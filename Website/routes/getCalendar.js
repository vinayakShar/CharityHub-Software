const db = require('../db/hero');

function getCharityInfo(req, res, checkLoggedIn) 
{
    const charityInfoQuery = 
    `SELECT
        org_account.name, org_details.*
    FROM
        org_account, org_details
    WHERE
        org_details.org_id = org_account.org_id;`;

    var getEventsQuery = `SELECT * FROM event WHERE event_date >= CURRENT_DATE ORDER BY event_date;`;

    db.query(charityInfoQuery)
    .then(data => {
        db.query(getEventsQuery)
        .then(eventData => {
            res.render('pages/calendar.ejs', {
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
    loadCalendar: (req, res, checkLoggedIn) => { getCharityInfo(req, res, checkLoggedIn) }
}