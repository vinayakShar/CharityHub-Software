const db = require('../db/hero');

function getHistory(req, res, checkLoggedIn) 
{
	var donationQuery = '';
	if(req.user){
		donationQuery = 
		`SELECT 
			org_account.name, payment.* 
		FROM 
			org_account, payment 
		WHERE 
			payment.account_id = '${req.user.account_id}' 
		AND 
			org_account.org_id = payment.payment_id;`;
	}

    db.query(donationQuery)
    .then(data => {
        res.render('pages/history.ejs', {
            loggedIn: checkLoggedIn(req),
            failLoggedInMessage: req.flash('error'),
    		user: req.user,
            donation: data.rows
        });
    })
    .catch(err => {
        console.log(err);
        res.status(500).send("Error code 500: Internal server error");
    })
}

module.exports = {
    loadHistory: (req, res, checkLoggedIn) => { getHistory(req, res, checkLoggedIn) }
}