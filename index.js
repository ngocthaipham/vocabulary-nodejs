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

app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
  });

// crud sources
app.get('/sources', function (req, res) {   // get list sources
    db.query('SELECT * FROM source', function (err, result) {
        if(err) throw err;
        return res.send(result);
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
    db.query("INSERT INTO source SET ? ", source , function (err, results) {
        if (err) throw err;
        return res.redirect('/sources');
    });
});

app.put('/sources/:id', function (req, res) {        //update source
    let idSource = parseInt(req.params.id);
    let nameSource = req.body.nameSource;
    let desSource = req.body.desSource;
    db.query("UPDATE source SET nameSource = ?, desSource = ? WHERE idSource = ?",[nameSource, desSource, idSource], function (err,result) {
        if (err) throw err;
        return res.redirect('/sources');
    });
});

app.delete('/sources/:id', function (req, res) {   //delete source
    let idSource = parseInt(req.params.id);
    db.query("DELETE FROM source WHERE idSource = ?", idSource, function (err,result) {
        if (err) throw err;
        return res.redirect('/sources');
    });
});

// crud words
app.get('/sources/levels/words', function (req, res) {
    db.query("SELECT * FROM word",function (err,result) {
        if(err) throw err;
        return res.send(result);
    });
});

app.get('/sources/levels/words/:id', function (req, res) {   // get list words of levels
    let idLevel = parseInt(req.params.id);
    db.query('SELECT vocab, meaning FROM word WHERE idLevel = ?', idLevel , function (err, result) {
        if(err) throw err;
        return res.send(result);
    });
});

app.post('/sources/levels/words/:id', function (req, res) {   // add word
    let idLevel = parseInt(req.params.id);
    let vocab = req.body.vocab;
    let meaning = req.body.meaning;
    db.query("INSERT INTO word SET vocab = ?, meaning = ?, idLevel = ?",[ vocab, meaning, idLevel ], function (err, result) {
        if(err) throw err;
        res.redirect('/sources/levels/words');
    });
});

app.put('/sources/levels/words/:id', function (req, res) {  //update word
    let id = parseInt(req.params.id);
    let idLevel = req.body.idLevel;
    let vocab = req.body.vocab;
    let meaning = req.body.meaning;
    db.query("UPDATE word SET idLevel = ? , vocab = ? , meaning = ? WHERE id = ?", [idLevel, vocab, meaning, id], function (err, result){
        if(err) throw err;
        res.redirect('/sources/levels/words');
    });
});

app.delete('/sources/levels/words/:id', function (req, res) {  // delete word
    let id = parseInt(req.params.id);
    db.query("DELETE FROM word WHERE id = ?", id , function (err, result){
        if(err) throw err;
        res.redirect('/sources/levels/words');
    });
});

// crud levels
app.get('/sources/levels', function (req, res) {
    db.query("SELECT * FROM level",function (err,result) {
        if(err) throw err;
        return res.send(result);
    })
})

app.get('/sources/levels/:id', function (req, res) {   // get list levels of sources
    let idSource = parseInt(req.params.id);
    db.query('SELECT level, idSource FROM level WHERE idSource = ?', idSource , function (err, result) {
        if(err) throw err;
        return res.send(result);
    })
})

app.post('/sources/levels/:id', function (req, res) {   //create level
    let idLevel = req.body.idLevel;
    let level = req.body.level
    let idSource = parseInt(req.params.id);
    db.query("INSERT INTO level SET idLevel = ?, level = ? , idSource = ? ", [ idLevel, level, idSource ] , function (err, results) {
        if (err) throw err;
        return res.redirect('/sources/levels');
    });
}); 

app.put('/sources/levels/:id', function (req, res) {    // update level
    level = req.body.level;
    idSource = req.body.idSource;
    idLevel = parseInt(req.params.id);
    db.query("UPDATE level SET level = ?, idSource = ? WHERE idLevel = ?",[ level, idSource, idLevel ], function (err, results){
        if(err) throw err;
        return res.redirect('/sources/levels');
    });
});

app.delete('/sources/levels/:id', function (req, res) {   // delete level
    idLevel = parseInt(req.params.id);
    db.query("DELETE FROM level WHERE idLevel = ?", idLevel, function(err, results){
        if(err) throw err;
        return res.redirect('/sources/levels');
    });
});

  
app.listen(port);
console.log('Server listening on port : ' + port);
