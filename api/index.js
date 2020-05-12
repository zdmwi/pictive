import express from 'express'
import mysql from 'mysql'

const connection = mysql.createConnection({
  host: process.env.MYSQL_HOST || 'localhost',
  user: process.env.MYSQL_USER || 'root',
  password: process.env.MYSQL_PASSWORD || '0000',
  port: '3306',
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
  const sql = 'select * from users limit 10'
  connection.query(sql, (error, results, fields) => {
    if (error) throw error
    return res.json({
      code: 1,
      data: results
    })
  })
  connection.end()
})

// get a user's friends
router.get('/users/:id/friends', (req, res) => {
  const { id } = req.params
  console.log('The id is ', id)

  // const sql = `select u.fname, u.lname, u.user_id, u.email, f.group_t as friend_group from users as u join friend_of as f on u.user_id = f.friend_id where f.user_id=${id} limit 10`
  const sql = `call getFriends(${id}, 5)`
  connection.connect()
  connection.query(sql, (error, results) => {
    if (error) throw error
    console.log(results)
    return res.json({
      code: 1,
      data: results[0]
    })
  })
  connection.end()
})

// get a user's photo posts
router.get('/users/:id/photos', (req, res) => {
  const { id } = req.params

  const sql = `select p.url, p.caption, p.post_id, po.created_on from photos as p join posts as po on p.post_id = po.post_id where po.user_id=${id} limit 10`

  connection.connect()
  connection.query(sql, (error, results) => {
    if (error) throw error
    return res.json({
      code: 1,
      data: results
    })
  })
  connection.end()
})

// get a user's photo text posts
router.get('/users/:id/texts', (req, res) => {
  const { id } = req.params

  const sql = `select t.body, t.post_id, po.created_on from texts as t join posts as po on t.post_id = po.post_id where po.user_id=${id} limit 10`

  connection.connect()
  connection.query(sql, (error, results) => {
    if (error) throw error
    return res.json({
      code: 1,
      data: results
    })
  })
  connection.end()
})

// get a user's comments
router.get('/users/:id/comments', (req, res) => {
  const { id } = req.params

  // friend_of, user i want all comments whre id = user's
  const sql = `select c.comment, c.c_date, c.post_id from comments_on as c where user_id=${id} limit 10`

  connection.connect()
  connection.query(sql, (error, results) => {
    if (error) throw error
    return res.json({
      code: 1,
      data: results
    })
  })
  connection.end()
})

// get a user's profile
router.get('/users/:id/profile', (req, res) => {
  const { id } = request.params

  const sql = `select * from profile where user_id=${id} `

  connection.connect()
  connection.query(sql, (error, results) => {
    if (error) throw error
    return res.json({
      code: 1,
      data: results
    })
  })
  connection.end()
})

router.get('/groups', (req, res) => {
  connection.connect()

  connection.end()
})

router.post('/login', (req, res) => {
  connection.connect()

  connection.end()
})

export default {
  path: '/api',
  handler: router
}
