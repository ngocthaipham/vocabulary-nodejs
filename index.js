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

// crud sources
app.get('/sources', function (req, res) {   // get list sources
    db.query('SELECT * FROM source', function (err, result) {
        if(err) throw err;
        return res.send({ err: false , data: result , message: 'sources list'});
    })
})

app.post('/sources', function (req, res) {   //create source
    let idSource = req.body.idSource;
    let nameSource = req.body.nameSource;
    let desSource = req.body.desSource;
    let source = { idSource: idSource,
                   nameSource: nameSource,  
                   desSource: desSource };
    if (!source) {
        return res.status(400).send({ error:true, message: 'Please provide source' });
    }
    db.query("INSERT INTO source SET ? ", source , function (error, results) {
        if (error) throw error;
        return res.send({ error: false, data: results, message: 'New source has been created successfully.' });
    });
    res.redirect('/sources')
});

// crud levels
app.get('/sources/levels', function (req, res) {   // get list levels of sources
    db.query('SELECT * FROM level', function (err, result) {
        if(err) throw err;
        return res.send({ err: false , data: result , message: 'levels list'});
    })
})

// crud words
app.get('/sources/levels/words', function (req, res) {   // get list words of levels
    db.query('SELECT * FROM word', function (err, result) {
        if(err) throw err;
        return res.send({ err: false , data: result , message: 'words list'});
    })
})

app.get('/',function(req, res){
    res.send('Welcome to my server');
})

app.listen(port);
console.log('Server listening on port : ' + port);
