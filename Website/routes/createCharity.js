const db = require('../db/hero');

module.exports = (req) => {
	//org_account
	//org_id
	const orgID = db.query(`SELECT org_id FROM org_account ORDER BY org_id DESC LIMIT 1;`) + 1
	
	//name
	const orgName = req.body.charity_name
	
	//create_date and last_update
	const currentDate = Date.now()
	
	//email
	const orgEmail = req.user.email
	
	//password
	const orgPassword = req.user.password
	
	//form_link
	const orgForm = 'dev/forms/taxevasion.form'

	//insert types
	const insertTypes = `(org_id, name, create_date, email, password, payment_id, activebool, verifiedbool, last_update, form_link)`

	//table insert (payment_id and bools set to 1 for now)
	db.query(`INSERT INTO org_account${insertTypes} VALUES(${orgID}, '${orgName}', '${currentDate}', '${orgEmail}', '${orgPassword}', 1, 1, 1, '${currentDate}', ${orgForm});`)


	//org_details
	const orgTag = req.body.charity_tag
	const orgMission = req.body.charity_mission
	const orgType1 = req.body.charity_type1
	const orgType2 = req.body.charity_type2
	const orgType3 = req.body.charity_type3
	const orgURL = req.body.charity_url
	const orgURLfb = req.body.charity_url_fb
	const orgURLtw = req.body.charity_url_tw
	const orgURLin = req.body.charity_url_in
	const orgAddress = req.body.charity_contact

	const insertTypesDetails = `(org_id, tag, mission, type1, type2, type3, url, url_fb, url_tw, url_in, address_id)`
	db.query(`INSERT INTO org_details${insertTypesDetails} VALUES(${orgID}, '${orgTag}', '${orgMission}', '${orgType1}', '${orgType2}', '${orgType3}', '${orgURL}', '${orgURLfb}', '${orgURLtw}', '${orgURLin}', '${orgAddress}');`)



}