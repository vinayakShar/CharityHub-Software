// Create a connection to the Cloud(heroku) PostgreSQL server


const { Client } = require('pg');

process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0';

var pg = require('pg');
var params = { host: 'ec2-34-232-24-202.compute-1.amazonaws.com',user: 'ccymiucxeppyjz',
  password: 'facdd2d9c5c6beec0a7c23a93983082695eec0fc5460e67ae3f8bcbae31ebd9e',
  database: 'da21001os1ce9n',ssl: true };
var client = new pg.Client(params);
client.connect();

module.exports = {
    query: (text, params, callback) => {
        return client.query(text, params, callback);
    }
}


console.log('- - - - -Abracadabra, 5432 is the magic port- - - - -');


/*
client.query('SELECT table_schema,table_name FROM information_schema.tables;', (err, res) => {
  if (err) throw err;
  for (let row of res.rows) {
    console.log(JSON.stringify(row));
  }
  client.end();
});
*/

/*


//DATABASE_URL:
// postgres://ccymiucxeppyjz:facdd2d9c5c6beec0a7c23a93983082695eec0fc5460e67ae3f8bcbae31ebd9e@ec2-34-232-24-202.compute-1.amazonaws.com:5432/da21001os1ce9n

require('dotenv').config()

const {Pool} = require('pg')
const isProduction = process.env.NODE_ENV === 'production'

// connectionString FORMAT: 'postgresql://USER:PASSWORD@HOST:PORT/DATABASE'
const connectionString = 'postgres://ccymiucxeppyjz:facdd2d9c5c6beec0a7c23a93983082695eec0fc5460e67ae3f8bcbae31ebd9e@ec2-34-232-24-202.compute-1.amazonaws.com:5432/da21001os1ce9n'

// connectionString FORMAT: 'postgresql://USER:PASSWORD@HOST:PORT/DATABASE'
//const connectionString = 'postgresql://dhsbjloabfzwwd:44b8af06743793e1589fbcf1e0e940fba46d46ee8506e1f1474301d6ef859f9d'
//+ '@ec2-34-231-56-78.compute-1.amazonaws.com:5432/de82p5lvl2ekjf'

const pool = new Pool({
  connectionString: isProduction ? process.env.DATABASE_URL : connectionString,
  ssl: isProduction,
})

module.exports = {pool}


/*

--
--
--
const client = new Client({
  // connectionString FORMAT: 'postgresql://USER:PASSWORD@HOST:PORT/DATABASE'
  connectionString: `'postgresql://dhsbjloabfzwwd:44b8af06743793e1589fbcf1e0e940fba46d46ee8506e1f1474301d6ef859f9d'
  + '@ec2-34-231-56-78.compute-1.amazonaws.com:5432/de82p5lvl2ekjf'`,
  ssl: {
    rejectUnauthorized: false
  }
});

client.connect();

*/
