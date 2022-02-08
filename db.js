const pg = require('pg');

const postgresUrl = process.env.DATABASE_URL || 'postgres://localhost/atp_rankings';

const client = new pg.Client(postgresUrl);

module.exports = client