// Create a connection to the PostgreSQL server 
const Pool = require('pg').Pool;

const pool = new Pool({
  user: "server",
  host: "localhost",
  database: "charityhub",
  password: "password",
  port: 5432
});

module.exports = {
    query: (text, params, callback) => {
        return pool.query(text, params, callback);
    }
}