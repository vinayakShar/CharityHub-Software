const db = require('../db/hero');

module.exports = (req) => {
    insertPayment(req)
}

function insertPayment(req) {
    const selectIdsQuery = `
    SELECT
   org_account.org_id, user_account.account_id
    FROM
        org_account, user_account
    WHERE
        org_account.name = '${req.body.charity}' AND
        user_account.username = '${req.body.username}'
    LIMIT 1;`;

    const selectTransactionIdQuery = `
    SELECT
   transaction_id
    FROM
        payment
    ORDER BY
        transaction_id DESC
    LIMIT 1;`;

    // Obtain org and account ids
    db.query(selectIdsQuery)
    .then(res => {
        const payment_id = res.rows[0].org_id
        const account_id = res.rows[0].account_id
        // Obtain new transaction id from most recent transaction id in table
        db.query(selectTransactionIdQuery)
        .then(res => {
            const insertQuery = `
            INSERT INTO
                payment
            VALUES(
                ${res.rows[0].transaction_id + 1},
                ${payment_id},
                ${account_id},
                0.00,
                (to_timestamp(${Date.now()} / 1000)),
                1
            );`;
            // Insert payment info into payment table
            db.query(insertQuery)
            .then(res => {
                console.log("Payment insert successful! Check table.")
            })
            .catch(err => {
                console.log("Insert payment error")
                console.log(err)
            })
        })
        .catch(err => {
            console.log("Select transaction id error")
            console.log(err)
        })
    })
    .catch(err => {
        console.log("Select org and account ids error")
        console.log(err)
    })
}
