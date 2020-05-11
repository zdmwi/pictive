import express from 'express'
import mysql from 'mysql'

const connection = mysql.createConnection({
  host: process.env.MYSQL_HOST || 'localhost',
  user: process.env.MYSQL_USER || 'admin',
  password: process.env.MYSQL_PASSWORD || 'password',
  database: process.env.MYSQL_DB || 'relatable',
  multipleStatements: true
})

// Create express router
const router = express.Router()

// Transform req & res to have the same API as express
// So we can use res.status() & res.json()
const app = express()
router.use((req, res, next) => {
  Object.setPrototypeOf(req, app.request)
  Object.setPrototypeOf(res, app.response)
  req.res = res
  res.req = req
  next()
})

router.get('/users', (req, res) => {
  connection.connect()
  connection.query('SELECT 1 + 1 AS solution', (error, results, fields) => {
    if (error) throw error
    res.send(results)
  })
  connection.end()
})

export default {
  path: '/api',
  handler: router
}
