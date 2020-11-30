const db = require('../db/hero');

module.exports = (req) => {
	const eventID = db.query(`SELECT event_id FROM event ORDER BY event_id DESC LIMIT 1;`) + 1

	const eventTitle = req.body.event_name

	const eventDate = req.body.event_date

	const eventOrg = 10

	const eventDes = req.body.event_desc

	const insertTypes = `(event_id, title, event_date, org_id, description)`

	if(req.body.event_time){
		const eventTime = req.body.event_time
		insertTypes = `(event_id, title, event_date, event_time, org_id, description)`
		db.query(`INSERT INTO event${insertTypes} VALUES(${eventID}, '${eventTitle}', '${eventDate}', '${eventTime}', ${eventOrg}, '${eventDes}');`)
	}
	else{
		db.query(`INSERT INTO event${insertTypes} VALUES(${eventID}, '${eventTitle}', '${eventDate}', ${eventOrg}, '${eventDes}');`)
	}

}