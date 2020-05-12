import express from 'express'
import mysql from 'mysql'
import bodyParser from 'body-parser'

const connection = mysql.createConnection({
  host: process.env.MYSQL_HOST || 'localhost',
  user: process.env.MYSQL_USER || 'root',
  password: process.env.MYSQL_PASSWORD || '0000',
  port: '3306',
  database: process.env.MYSQL_DB || 'relatable',
  multipleStatements: true
})

connection.connect()

// Create express router
const router = express.Router()

// Transform req & res to have the same API as express
// So we can use res.status() & res.json()
const app = express()
// app.use(bodyParser.json())
router.use(bodyParser.json())
router.use((req, res, next) => {
  Object.setPrototypeOf(req, app.request)
  Object.setPrototypeOf(res, app.response)
  req.res = res
  res.req = req
  next()
})

router.get('/users', (req, res) => {
  const sql = 'select * from users '
  connection.query(sql, (error, results, fields) => {
    if (error) throw error
    return res.json({
      code: 1,
      data: results
    })
  })
})

// get a user's friends
router.get('/users/:id/friends', (req, res) => {
  const { id } = req.params
  console.log('The id is ', id)

  // const sql = `select u.fname, u.lname, u.user_id, u.email, f.group_t as friend_group from users as u join friend_of as f on u.user_id = f.friend_id where f.user_id=${id} `
  const sql = `call friendinfo(${id})`

  connection.query(sql, (error, results) => {
    if (error) throw error
    console.log(results)
    return res.json({
      code: 1,
      data: results[0]
    })
  })
})

// get a user's photo posts
router.get('/users/:id/photos', (req, res) => {
  const { id } = req.params

  const sql = `select p.url, p.caption, p.post_id, po.created_on from photos as p join posts as po on p.post_id = po.post_id where po.user_id=${id} `

  connection.query(sql, (error, results) => {
    if (error) throw error
    return res.json({
      code: 1,
      data: results
    })
  })
})

// get a user's photo text posts
router.get('/users/:id/texts', (req, res) => {
  const { id } = req.params

  const sql = `select t.body, t.post_id, po.created_on from texts as t join posts as po on t.post_id = po.post_id where po.user_id=${id} `

  connection.query(sql, (error, results) => {
    if (error) throw error
    return res.json({
      code: 1,
      data: results
    })
  })
})

// make a text post
router.post('/users/:id/texts', (req, res) => {
  const { id } = req.params
  const { body } = req.body

  const sql = `call makeTextPosts(${id}, ${body})`

  connection.query(sql, (error, results) => {
    if (error) throw error
    return res.json({
      code: 1,
      data: results
    })
  })
})

// get a user's comments
router.get('/users/:id/comments', (req, res) => {
  const { id } = req.params

  // friend_of, user i want all comments whre id = user's
  const sql = `select c.comment, c.c_date, c.post_id from comments_on as c where user_id=${id} `

  connection.query(sql, (error, results) => {
    if (error) throw error
    return res.json({
      code: 1,
      data: results
    })
  })
})

// get a user's profile
router.get('/users/:id/profile', (req, res) => {
  const { id } = request.params

  const sql = `select * from profile where user_id=${id} `

  connection.query(sql, (error, results) => {
    if (error) throw error
    return res.json({
      code: 1,
      data: results
    })
  })
})

router.get('/groups', (req, res) => {
  connection.query(sql, (error, results) => {
    if (error) throw error
    return res.json({
      code: 1,
      data: results
    })
  })
})

router.post('/login', (req, res) => {
  // connec
})

export default {
  path: '/api',
  handler: router
}
