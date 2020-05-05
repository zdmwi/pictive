const knexConfig = {
  client: 'mysql',
  connection: {
    host: '127.0.0.1',
    user: 'admin',
    password: '0000',
    database: 'relatable',
  },
};

export const knex = require('knex')(knexConfig);
