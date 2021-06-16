const express = require('express');
const app = express();
const mysql = require('mysql');
const router = express.Router();
const port = process.env.PORT || 5000 ;
const bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended: true })) ;
app.use(bodyParser.json());

var db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '123123',
    database: 'khoahoc'
});

db.connect(function(err) {
    if (err) throw err;
    console.log('connected')
})

app.get('/sources', function (req, res) {
    db.query('SELECT * FROM source', function (err, result) {
        if(err) throw err;
        return res.send({ err: false , data: result , message: 'sources list'});
    })
})

app.get('/sources/levels/words', function (req, res) {
    db.query('SELECT * FROM word', function (err, result) {
        if(err) throw err;
        return res.send({ err: false , data: result , message: 'words list'});
    })
})

app.get('/sources/levels', function (req, res) {
    db.query('SELECT * FROM level', function (err, result) {
        if(err) throw err;
        return res.send({ err: false , data: result , message: 'levels list'});
    })
})

app.get('/',function(req, res){
    res.send('Welcome to my server');
})

app.listen(port);
console.log('Server listening on port : ' + port);
