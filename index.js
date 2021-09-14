const express = require("express");
const app = express();
const mysql = require("mysql");
const router = express.Router();
const port = process.env.PORT || 5000;
const bodyParser = require("body-parser");
const cors = require("cors");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const multer = require("multer");
const cookieParser = require("cookie-parser");
var path = require("path");

app.use(cookieParser());
// app.use(cors());
app.use(cors({ credential: true, origin: "http://localhost:3000" }));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
var db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "123123",
  database: "khoahoc",
  port: 3306,
});

db.connect(function (err) {
  if (err) throw err;
  console.log("connected");
});

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Credentials", true);
  // res.header("Access-Control-Allow-Origin","*");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept"
  );
  next();
});
var storage = multer.diskStorage({
  destination: function (req, file, callback) {
    if (file.fieldname === "audioWord") {
      callback(null, "./audios");
    } else {
      callback(null, "./images");
    }
  },
  filename: function (req, file, callback) {
    if (file.fieldname === "audioWord") {
      callback(
        null,
        file.fieldname + Date.now() + path.extname(file.originalname)
      );
    } else {
      callback(
        null,
        file.fieldname + Date.now() + path.extname(file.originalname)
      );
    }
  },
});

var upload = multer({ storage: storage });

app.use("/images", express.static("images"));

var audioStorage = multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, "./audios");
  },
  filename: function (req, file, callback) {
    callback(
      null,
      file.fieldname + Date.now() + path.extname(file.originalname)
    );
  },
});

var uploadAudio = multer({ storage: audioStorage });

app.use("/audios", express.static("audios"));

var uploadMultiple = upload.fields([
  { name: "imageWord", maxCount: 1 },
  { name: "audioWord", maxCount: 1 },
]);

// crud sources
app.get(
  "/sources/:username/:privateState/page:page",
  isLoggedIn,
  function (req, res) {
    // get list sources
    let totalCourse ;
    let data ;
    const limit = 3;
    const page = req.params.page;
    const offset = (page - 1) * limit;
    let userName = req.params.username;
    let privateState = req.params.privateState;
    let compareCurDayWithLatestDay;
    let scoreOfLatestDay;
    db.query(
      `SELECT * FROM source  WHERE userName = ? AND private = ? LIMIT ${limit} OFFSET ${offset}`,
      [userName, privateState],
      function (err, result) {
        data= result;
        if (err) throw err;
        db.query(
          `SELECT COUNT(idSource) AS count FROM source  WHERE userName = ? AND private = ?`, [userName, privateState],
          function (err, bResult) {
            if (err) throw err;
            totalCourse = bResult[0].count;
            return res.send({result : data ,
            totalCourse: totalCourse, coursePerPage: limit});
          }
        );
      }
    );
   
    db.query(
      `SELECT sum(score) as totalScore from learning WHERE userName= ? AND date = curdate()`,
      [userName],
      function (err, results) {
        if (err) throw err;
        db.query(
          `SELECT DATEDIFF(now(), (SELECT MAX(date) FROM learning WHERE userName = ?)) as date`,
          userName,
          function (bErr, bResults) {
            if (bErr) throw bErr;
            if (bResults[0]["date"] >= 1) {
              results[0]["totalScore"] = 0;
            }
          }
        );
        scoreOfLatestDay = results[0]["totalScore"];
        if (scoreOfLatestDay === null) {
          scoreOfLatestDay = 0;
        }
      }
    );
    db.query(
      `SELECT DATEDIFF(now(), (SELECT MAX(date) FROM learning WHERE userName = ?)) as date`,
      userName,
      function (err, results) {
        if (err) throw err;
        compareCurDayWithLatestDay = results[0]["date"];
        if (
          compareCurDayWithLatestDay > 1 ||
          compareCurDayWithLatestDay === null
        ) {
          db.query(
            `UPDATE user SET streak = 0 WHERE userName = ?`,
            userName,
            function (err, results) {
              if (err) throw err;
            }
          );
        }
        if (compareCurDayWithLatestDay === 1) {
          db.query(
            `UPDATE user SET streakUpdated = 0 WHERE userName = ?`,
            userName,
            function (err, results) {
              if (err) throw err;
            }
          );
        }
      }
    );
  }
);
app.get("/sources/:privateState/page:page", function (req, res) {
  let totalCourse ;
  const page = req.params.page;
  const limit = 4 * page;
  const offset = 0;

  let privateState = req.params.privateState;
  db.query(
    `SELECT * FROM source WHERE private = ? ORDER BY likes DESC LIMIT ${limit} OFFSET ${offset} `,
    privateState,
    function (err, results) {
      if (err) throw err;
      // return res.send(results);
      db.query(
        `SELECT COUNT(idSource) AS count FROM source  WHERE  private = ?`, [privateState],
        function (err, bResult) {
          if (err) throw err;
          totalCourse = bResult[0].count;
          return res.send({result : results ,
          totalCourse: totalCourse, coursePerPage: limit});
        }
      );
    }
  );
});

app.get("/source/:id", function (req, res) {
  // get list sources
  let idSource = parseInt(req.params.id);
  db.query(
    "SELECT * FROM source WHERE idSource = ?",
    idSource,
    function (err, results) {
      if (err) throw err;
      return res.send({countRating: results[0].countRating,
        countComment: results[0].comments});
    }
  );
});

app.post("/sources", upload.single("imageSource"), function (req, res) {
  //create source
  let nameSource = req.body.nameSource;
  let desSource = req.body.desSource;
  let userName = req.body.userName;
  let imageSource = req.file.filename;
  let source = {
    // idSource: idSource,
    nameSource: nameSource,
    desSource: desSource,
    userName: userName,
    imageSource: imageSource,
  };
  if (!source) {
    return res
      .status(400)
      .send({ error: true, message: "Please provide source" });
  }
  db.query("INSERT INTO source SET ? ", source, function (err, results) {
    if (err) throw err;
    return res.send("create success");
  });
});

app.put("/sources/:id", upload.single("imageSource"), function (req, res) {
  //update source
  let idSource = parseInt(req.params.id);
  let nameSource = req.body.nameSource;
  let desSource = req.body.desSource;
  let imageSource = req.file.filename;
  let private = req.body.private;
  db.query(
    "UPDATE source SET nameSource = ?, desSource = ?, imageSource=?, private = ? WHERE idSource = ?",
    [nameSource, desSource, imageSource, private, idSource],
    function (err, result) {
      if (err) throw err;
      return res.send("update success");
    }
  );
});

app.delete("/sources/:id", function (req, res) {
  //delete source
  let idSource = parseInt(req.params.id);
  db.query(
    "DELETE FROM source WHERE idSource = ?",
    idSource,
    function (err, result) {
      if (err) throw err;
      return res.send("delete success");
    }
  );
});

// crud words
app.get("/words", function (req, res) {
  db.query("SELECT * FROM word", function (err, result) {
    if (err) throw err;
    return res.send(result);
  });
});

app.get("/words/:id", function (req, res) {
  // get list words of levels
  let idLevel = parseInt(req.params.id);
  db.query(
    "SELECT * FROM word WHERE idLevel = ?",
    idLevel,
    function (err, result) {
      if (err) throw err;
      return res.send(result);
    }
  );
});

app.get("/vocabs/:id", function (req, res) {
  // get list words of levels
  let idLevel = parseInt(req.params.id);
  db.query(
    "SELECT id, vocab, meaning, imageWord, audioWord, learningPoint FROM word WHERE idLevel = ?",
    idLevel,
    function (err, result) {
      if (err) throw err;
      return res.send(result);
    }
  );
});

app.get("/learningPoint/:id", function (req, res) {
  // get list words of levels
  let idLevel = parseInt(req.params.id);
  db.query(
    "SELECT learningPoint FROM word WHERE idLevel = ?",
    idLevel,
    function (err, result) {
      if (err) throw err;
      return res.send(result);
    }
  );
});
app.get("/vocabsLearn/:id/:isLearned", function (req, res) {
  // get list words of levels
  let idLevel = parseInt(req.params.id);
  let isLearned = parseInt(req.params.isLearned);
  db.query(
    "SELECT * FROM word WHERE idLevel = ? AND isLearned = ? ORDER BY learningPoint DESC",
    [idLevel, isLearned],
    function (err, result) {
      if (err) throw err;
      if (result.length !== 0) {
        return res.send(result);
      }
      return res.send();
    }
  );
});

app.post("/words/:id", function (req, res) {
  // add word
  let idLevel = parseInt(req.params.id);
  let vocab = req.body.vocab;
  let meaning = req.body.meaning;
  db.query(
    "INSERT INTO word SET vocab = ?, meaning = ?, idLevel = ?",
    [vocab, meaning, idLevel],
    function (err, result) {
      if (err) throw err;
      res.send("create success");
    }
  );
});

app.post("/words", uploadMultiple, function (req, res) {
  // add word
  let idSource = req.body.idSource;
  let idLevel = req.body.idLevel;
  let level = req.body.level;
  let vocab = req.body.vocab;
  let meaning = req.body.meaning;
  let imageWord = req.files.imageWord[0].filename;
  let audioWord = req.files.audioWord[0].filename;
  let userName = req.body.userName;
  db.query(
    "INSERT INTO word SET  idSource = ?, idLevel = ?, level = ?, vocab = ?, meaning = ?, imageWord= ?,audioWord=?, userName= ?",
    [idSource, idLevel, level, vocab, meaning, imageWord, audioWord, userName],
    function (err, result) {
      if (err) throw err;
      res.send("create success");
    }
  );
});

app.put("/words/:id", uploadMultiple, function (req, res) {
  //update word
  let id = parseInt(req.params.id);
  let idSource = req.body.idSource;
  let idLevel = req.body.idLevel;
  let level = req.body.level;
  let vocab = req.body.vocab;
  let meaning = req.body.meaning;
  let imageWord = req.files.imageWord[0].filename;
  let audioWord = req.files.audioWord[0].filename;
  let userName = req.body.userName;
  db.query(
    "UPDATE word SET idSource = ?, idLevel = ? , level = ?, vocab = ? , meaning = ? , imageWord = ? , audioWord = ?, userName = ? WHERE id = ?",
    [
      idSource,
      idLevel,
      level,
      vocab,
      meaning,
      imageWord,
      audioWord,
      userName,
      id,
    ],
    function (err, result) {
      if (err) throw err;
      res.send("update success");
    }
  );
});

app.delete("/words/:id", function (req, res) {
  // delete word
  let id = parseInt(req.params.id);
  db.query("DELETE FROM word WHERE id = ?", id, function (err, result) {
    if (err) throw err;
    res.send("delete success");
  });
});

// crud levels
app.get("/levels", function (req, res) {
  db.query("SELECT * FROM level", function (err, result) {
    if (err) throw err;
    return res.send(result);
  });
});

app.get("/levels/:id", function (req, res) {
  // get list levels of sources
  let idSource = parseInt(req.params.id);
  // let userName = req.params.userName;
  db.query(
    "SELECT * FROM level WHERE idSource = ?",
    [idSource],
    function (err, result) {
      if (err) throw err;
      return res.send(result);
    }
  );
});

app.post("/levels/:id", function (req, res) {
  //create level
  let idLevel = req.body.idLevel;
  let level = req.body.level;
  let idSource = parseInt(req.params.id);
  db.query(
    "INSERT INTO level SET idLevel = ?, level = ? , idSource = ? ",
    [idLevel, level, idSource],
    function (err, results) {
      if (err) throw err;
      return res.send(" create success");
    }
  );
});

app.post("/levels", upload.single("imageLevel"), function (req, res) {
  //create level
  let level = req.body.level;
  let idSource = req.body.idSource;
  let imageLevel = req.file.filename;
  let userName = req.body.userName;
  db.query(
    "INSERT INTO level SET  level = ? , idSource = ?, imageLevel=? , userName=?",
    [level, idSource, imageLevel, userName],
    function (err, results) {
      if (err) throw err;
      return res.send("create success");
    }
  );
});

app.put("/levels/:id", upload.single("imageLevel"), function (req, res) {
  // update level
  let level = req.body.level;
  let idSource = req.body.idSource;
  let imageLevel = req.file.filename;
  let userName = req.body.userName;
  let idLevel = parseInt(req.params.id);
  db.query(
    "UPDATE level SET level = ?, idSource = ? , imageLevel= ? ,userName=? WHERE idLevel = ?",
    [level, idSource, imageLevel, userName, idLevel],
    function (err, results) {
      if (err) throw err;
      return res.send("update success");
    }
  );
});

app.delete("/levels/:id", function (req, res) {
  // delete level
  idLevel = parseInt(req.params.id);
  db.query(
    "DELETE FROM level WHERE idLevel = ?",
    idLevel,
    function (err, results) {
      if (err) throw err;
      return res.send("delete success");
    }
  );
});

app.post("/explore/addCourse", function (req, res) {
  let nameSource = req.body.nameSource;
  let desSource = req.body.desSource;
  let imageSource = req.body.imageSource;
  let userName = req.body.userName;
  db.query(
    "INSERT INTO source SET nameSource = ?, desSource = ?, imageSource = ?, userName = ?",
    [nameSource, desSource, imageSource, userName],
    function (err, results) {
      if (err) throw err;
    }
  );
});
app.post("/explore/addLevel/:idSource", function (req, res) {
  let userName = req.body.userName;
  let idSource = req.params.idSource;
  db.query(
    ` INSERT INTO level (level, idSource, imageLevel, userName) SELECT level, idSource, imageLevel, "${userName}" FROM level WHERE idSource=?`,
    [idSource],
    function (err, results) {
      if (err) throw err;
    }
  );
  db.query(
    "UPDATE level SET idSource = (SELECT MAX(idSource) FROM source WHERE userName =?) WHERE idSource=? AND userName =?",
    [userName, idSource, userName],
    function (err, results) {
      if (err) throw err;
    }
  );
});

app.post("/explore/addWord/:idSource", function (req, res) {
  let userName = req.body.userName;
  let idSource = req.params.idSource;
  db.query(
    `INSERT INTO word ( idSource, idLevel, level, vocab, meaning, imageWord, audioWord, userName) SELECT  idSource,idLevel,level, vocab, meaning, imageWord, audioWord, "${userName}" FROM word WHERE idSource = ? `,
    [idSource],
    function (err, results) {
      if (err) throw err;
    }
  );
  db.query(
    "UPDATE word SET idSource = (SELECT MAX(idSource) FROM source WHERE userName =?) WHERE idSource=? AND userName=?",
    [userName, idSource, userName],
    function (err, results) {
      if (err) throw err;
    }
  );
  db.query(
    "UPDATE word INNER JOIN level ON word.level = level.level AND word.idSource = level.idSource AND word.userName = level.userName SET word.idLevel = level.idLevel WHERE word.idSource=(SELECT MAX(idSource) FROM source WHERE userName =?)  AND word.userName = ?",
    [userName, userName],
    function (err, results) {
      if (err) throw err;
      {
        return res.send("success");
      }
    }
  );
});

app.get("/favorites/:userName", function (req, res) {
  userName = req.params.userName;
  db.query(
    "SELECT * FROM favoritecourse WHERE userName = ? ",
    [userName],
    function (err, results) {
      return res.send(results);
      // return res.send([{id: 0}])
    }
  );
});

app.post("/favorite/:userName", function (req, res) {
  db.query(
    "UPDATE source SET likes = likes + 1 WHERE idSource = ?",
    req.body.idSource,
    function (err, results) {
      if (err) throw err;
    }
  );
  db.query(
    `INSERT INTO favoritecourse (idSource, nameFavoriteCourse, desFavoriteCourse, imageFavoriteCourse, userName) SELECT idSource, nameSource, desSource, imageSource,"${req.params.userName}" FROM source WHERE idSource = ?`,
    req.body.idSource,
    function (err, results) {
      if (err) throw err;
      return res.send("Add to favorite success");
    }
  );
});

app.put("/favorite/:userName", function (req, res) {
  db.query(
    "UPDATE source SET likes = likes-1 WHERE idSource = ?",
    req.body.idSource,
    function (err, results) {
      if (err) throw err;
    }
  );
  db.query(
    `DELETE FROM favoritecourse WHERE idSource = ? AND userName = ?`,
    [req.body.idSource, req.params.userName],
    function (err, results) {
      if (err) throw err;
      return res.send("Remove success");
    }
  );
});
app.put("/privateCourse/:idSource", function (req, res) {
  let idSource = req.params.idSource;
  let private = req.body.private;
  db.query(
    "UPDATE source SET private = ? WHERE idSource = ?",
    [private, idSource],
    function (err, results) {
      if (err) throw err;
      return res.send("Success");
    }
  );
});

app.put("/publicCourse/:idSource", function (req, res) {
  let idSource = req.params.idSource;
  let private = req.body.private;
  db.query(
    "UPDATE source SET private = ? WHERE idSource = ?",
    [private, idSource],
    function (err, results) {
      if (err) throw err;
      return res.send("Success");
    }
  );
});

app.post("/learning/:userName", function (req, res) {
  let timeLearning = req.body.timeLearning;
  let score = req.body.score;
  let userName = req.params.userName;
  db.query(
    "INSERT INTO learning SET date = CURDATE(), timeLearning= ?, score =? , userName =?",
    [timeLearning, score, userName],
    function (err, results) {
      if (err) throw err;
      return res.send();
    }
  );
});
app.put("/learning/:userName", function (req, res) {
  let userName = req.params.userName;
  db.query(
    "UPDATE user SET totalTime= (SELECT SUM(timeLearning) FROM learning WHERE userName=?), totalScore = (SELECT SUM(score) FROM learning WHERE userName =?) WHERE userName= ?",
    [userName, userName, userName],
    function (err, results) {
      if (err) throw err;
      return res.send();
    }
  );
});

app.get("/time/:userName", function (req, res) {
  db.query(
    "SELECT id,DATE_FORMAT(date,'%d/%m/%Y') as date , sum(timeLearning) as totalTimeLearning, sum(score) as totalScore FROM learning WHERE userName=? GROUP BY date",
    req.params.userName,
    function (err, results) {
      if (err) throw err;
      return res.send(results);
    }
  );
});

app.get("/users/:userName", function (req, res) {
  db.query(
    "SELECT * FROM user WHERE userName= ?",
    req.params.userName,
    function (err, results) {
      if (err) throw err;
      return res.send(results);
    }
  );
});

app.get("/user/:userId", function (req, res) {
  db.query(
    "SELECT userAvatar FROM user WHERE userId= ?",
    req.params.userId,
    function (err, results) {
      if (err) throw err;
      return res.send(results);
    }
  );
});

app.put("/userTarget/:userName", function (req, res) {
  db.query(
    "UPDATE user SET target = ? WHERE userName = ?",
    [req.body.target, req.params.userName],
    function (err, results) {
      if (err) throw err;
      return res.send("Set target success");
    }
  );
});

app.post("/userStreak/:userName", function (req, res) {
  let userName = req.params.userName;
  let scoreOfLatestDay;
  let compareCurDayWithLatestDay;
  let target;
  let streakUpdated;
  db.query(
    `SELECT sum(score) as totalScore from learning WHERE userName= ? AND date = curdate()`,
    [userName],
    function (err, results) {
      if (err) throw err;
      db.query(
        `SELECT DATEDIFF(now(), (SELECT MAX(date) FROM learning WHERE userName = ?)) as date`,
        userName,
        function (bErr, bResults) {
          if (bErr) throw bErr;
          if (bResults[0]["date"] >= 1) {
            results[0]["totalScore"] = 0;
          }
        }
      );
      scoreOfLatestDay = results[0]["totalScore"];
      if (scoreOfLatestDay === null) {
        scoreOfLatestDay = 0;
      }
      return res.send();
    }
  );
  db.query(
    `SELECT target, streakUpdated FROM user WHERE userName = ?`,
    userName,
    function (err, results) {
      if (err) throw err;
      target = results[0]["target"];
      streakUpdated = results[0]["streakUpdated"];
    }
  );

  db.query(
    `SELECT DATEDIFF(now(), (SELECT MAX(date) FROM learning WHERE userName = ?)) as date`,
    userName,
    function (err, results) {
      if (err) throw err;
      compareCurDayWithLatestDay = results[0]["date"];
      if (compareCurDayWithLatestDay >= 1) {
        scoreOfLatestDay = 0;
      }

      if (
        (compareCurDayWithLatestDay === 0 &&
          scoreOfLatestDay >= target &&
          streakUpdated === 0) ||
        (compareCurDayWithLatestDay === 1 &&
          scoreOfLatestDay >= target &&
          streakUpdated === 0) ||
        (compareCurDayWithLatestDay === null &&
          scoreOfLatestDay >= target &&
          streakUpdated === 0)
      ) {
        db.query(
          `UPDATE user SET streak = streak + 1 WHERE userName = ?`,
          userName,
          function (err, results) {
            if (err) throw err;
          }
        );
        db.query(
          `UPDATE user SET streakUpdated = 1 WHERE userName = ?`,
          userName,
          function (err, results) {
            if (err) throw err;
          }
        );
        db.query(
          `SELECT streak FROM user WHERE userName = ?`,
          userName,
          function (err, results) {
            if (err) throw err;
            streak = results[0]["streak"];
          }
        );
      }
    }
  );
});

app.put("/updateLearningPoint/:idWord", function (req, res) {
  db.query(
    `UPDATE word SET learningPoint = learningPoint + ?, isLearned = 1 WHERE id=?`,
    [req.body.learningPoint, req.params.idWord],
    function (err, results) {
      if (err) throw err;
      return res.send("success");
    }
  );

  // })
  // app.put('/checkLearningPoint/:idWord', function(req, res) {

  db.query(
    `SELECT * FROM word WHERE id = ?`,
    req.params.idWord,
    function (err, results) {
      if (err) throw err;
      if (results[0].learningPoint < -1) {
        db.query(
          `UPDATE word SET learningPoint = -1 WHERE id=?`,
          req.params.idWord,
          function (err, results) {
            if (err) throw err;
          }
        );
      }
      if (results[0].learningPoint > 10) {
        db.query(
          `UPDATE word SET learningPoint = 10 WHERE id=?`,
          req.params.idWord,
          function (err, results) {
            if (err) throw err;
          }
        );
      }
      return res.send();
    }
  );
});

app.get("/status/:userName", function (req, res) {
  let userName = req.params.userName;
  let scoreOfLatestDay;
  let compareCurDayWithLatestDay;
  let target;
  let streak;
  let streakUpdated;
  db.query(
    `SELECT sum(score) as totalScore from learning WHERE userName= ? AND date = curdate()`,
    [userName, userName],
    function (err, results) {
      if (err) throw err;
      scoreOfLatestDay = results[0]["totalScore"];
      if (scoreOfLatestDay === null) {
        scoreOfLatestDay = 0;
      }
    }
  );
  db.query(
    `SELECT target, streakUpdated FROM user WHERE userName = ?`,
    userName,
    function (err, results) {
      target = results[0]["target"];
      streakUpdated = results[0]["streakUpdated"];
      if (err) throw err;
    }
  );

  db.query(
    `SELECT DATEDIFF(now(), (SELECT MAX(date) FROM learning WHERE userName = ?)) as date`,
    userName,
    function (err, results) {
      if (err) throw err;
      compareCurDayWithLatestDay = results[0]["date"];
      if (
        (compareCurDayWithLatestDay === 0 && scoreOfLatestDay >= target) ||
        (compareCurDayWithLatestDay === 1 && scoreOfLatestDay >= target) ||
        (compareCurDayWithLatestDay === null && scoreOfLatestDay >= target)
      ) {
        db.query(
          `SELECT streak FROM user WHERE userName = ?`,
          userName,
          function (err, results) {
            if (err) throw err;
            streak = results[0]["streak"];
            return res.send(
              `You have completed your daily target !!! You have streak ${streak} days.`
            );
          }
        );
      }
      if (scoreOfLatestDay < target) {
        return res.send(
          `You have completed ${scoreOfLatestDay}/${target} your target today !!!`
        );
      }
    }
  );
});

app.post("/signup", validateRegister, function (req, res) {
  db.query(
    `SELECT * FROM user WHERE LOWER(userName) = LOWER(${db.escape(
      req.body.userName
    )})`,
    function (err, results) {
      if (results.length) {
        return res
          .status(409)
          .send({ message: "This username is already in use!" });
      } else {
        bcrypt.hash(req.body.userPassword, 10, function (err, hash) {
          if (err) {
            throw err;
          } else {
            db.query(
              `INSERT INTO user SET  userName=?, userEmail=?, userYear=?, userPassword=?`,
              [
                req.body.userName,
                req.body.userEmail,
                parseInt(req.body.userYear),
                hash,
              ],
              function (err, results) {
                if (err) throw err;
                return res.status(201).send({ message: "Registered" });
              }
            );
          }
        });
      }
    }
  );
});

app.post("/login", function (req, res) {
  db.query(
    `SELECT * FROM user WHERE userName = ?`,
    req.body.userName,
    function (err, results) {
      if (err) {
        throw err;
      }
      if (!results.length) {
        return res
          .status(401)
          .send({ message: "Usernames or Password is incorrect" });
      }
      bcrypt.compare(
        req.body.userPassword,
        results[0]["userPassword"],
        (bErr, bResults) => {
          if (bErr) {
            return res
              .status(401)
              .send({ message: "Username or password is incorrect" });
          }
          if (bResults) {
            const token = jwt.sign(
              { userName: results[0].userName, userId: results[0].userId },
              "SECRETKEY"
            );
            return res.status(200).send({token: token, userId : results[0].userId});
          }
          return res
            .status(401)
            .send({ message: "Username or password is incorrect" });
        }
      );
    }
  );
});

app.get("/logout", function (req, res) {
  res.clearCookie("token").send("logout success");
});

app.post("/images", upload.single("image"), function (req, res) {
  db.query(
    " INSERT INTO image SET image=?",
    req.file.filename,
    function (err, results) {
      if (err) throw err;
      console.log(req.file);
      return res.send("upload success");
    }
  );
});

app.put("/images/:id", upload.single("imageSource"), function (req, res) {
  db.query(
    " UPDATE source SET imageSource=? WHERE idSource=?",
    [req.file.filename, parseInt(req.params.id)],
    function (err, results) {
      if (err) throw err;
      console.log(req.file);
      return res.send(req.file.filename);
    }
  );
});

app.put("/images/level/:id", upload.single("imageLevel"), function (req, res) {
  db.query(
    " UPDATE level SET imageLevel=? WHERE idLevel=?",
    [req.file.filename, parseInt(req.params.id)],
    function (err, results) {
      if (err) throw err;
      console.log(req.file);
      return res.send(req.file.filename);
    }
  );
});

app.put("/images/word/:id", upload.single("imageWord"), function (req, res) {
  db.query(
    " UPDATE word SET imageWord=? WHERE id=?",
    [req.file.filename, parseInt(req.params.id)],
    function (err, results) {
      if (err) throw err;
      console.log(req.file);
      return res.send(req.file.filename);
    }
  );
});

app.put(
  "/audios/word/:id",
  uploadAudio.single("audioWord"),
  function (req, res) {
    db.query(
      " UPDATE word SET audioWord=? WHERE id=?",
      [req.file.filename, parseInt(req.params.id)],
      function (err, results) {
        if (err) throw err;
        console.log(req.file);
        return res.send(req.file.filename);
      }
    );
  }
);

app.get("/images", function (req, res) {
  db.query("SELECT * FROM image", function (err, results) {
    return res.send(results);
  });
});

app.post("/audios", uploadAudio.single("audio"), function (req, res) {
  db.query(
    " INSERT INTO audio SET audio=?",
    req.file.filename,
    function (err, results) {
      if (err) throw err;
      console.log(req.file);
      return res.send(req.file.filename);
    }
  );
});

app.get("/audios", function (req, res) {
  db.query("SELECT * FROM audio", function (err, results) {
    return res.send(results);
  });
});

app.post("/rating/:idCourse", function (req, res) {
  db.query(
    "INSERT INTO rating SET idCourse = ?, star = ?, byUser = ?",
    [req.params.idCourse, req.body.star, req.body.byUser],
    function (err, results) {
      return res.send("Rating success");
    }
  );
});

app.get("/rating/:idCourse", function (req, res) {
  db.query(
    "SELECT * FROM rating WHERE idCourse = ?",
    [req.params.idCourse],
    function (err, results) {
      res.send(results);
    }
  );
});

app.put("/putRating/:idCourse", function (req, res) {
  var countRating;
  var avgStar;
  db.query(
    "SELECT COUNT(idRating) AS count FROM rating WHERE idCourse = ?",
    req.params.idCourse,
    function (err, results) {
      countRating = results[0]["count"];
      db.query(
        "SELECT AVG(star) AS star FROM rating WHERE idCourse = ?",
        req.params.idCourse,
        function (err, results) {
          avgStar = results[0]["star"];
          db.query(
            "UPDATE source SET star = ? , countRating= ? WHERE idSource = ?",
            [avgStar, countRating, req.params.idCourse],
            function (err, results) {
              if (err) throw err;
              res.send(`${countRating}, ${avgStar}`);
            }
          );
        }
      );
    }
  );
});

app.get("/getComment/:idCourse", function (req, res) {
  db.query(
    "SELECT * FROM comment WHERE idCourse = ?",
    req.params.idCourse,
    function (err, results) {
      res.send(results);
    }
  );
});

app.post("/comment/:idCourse", function (req, res) {
  let countComment;
  db.query(
    "INSERT INTO comment SET comment = ?, byUser = ? , idCourse = ?",
    [req.body.comment, req.body.byUser, req.params.idCourse],
    function (err, results) {
      res.send("send comment success");
    }
  );
  db.query(
    "SELECT COUNT(idComment) AS count FROM comment WHERE idCourse = ?",
    req.params.idCourse,
    function (err, results) {
      countComment = results[0]["count"];
      db.query(
        "UPDATE source SET comments = ? WHERE idSource = ?",
        [countComment, req.params.idCourse],
        function (err, results) {
          if (err) throw err;
        }
      );
    }
  );
});

function validateRegister(req, res, next) {
  if (!req.body.userName || req.body.userName.length < 3) {
    return res
      .status(400)
      .send({ message: "Please enter a username with min 3 chars" });
  }
  if (!req.body.userPassword || req.body.userPassword.length < 6) {
    return res
      .status(400)
      .send({ message: "Please enter a password with min 6 chars" });
  }
  next();
}

function isLoggedIn(req, res, next) {
  try {
    const token = req.cookies.token;
    const decodedToken = jwt.verify(token, "SECRETKEY");
    req.userData = decodedToken;
    next();
  } catch (err) {
    return res
      .status(401)
      .json({ message: "invalid or expired token provided", error: err });
  }
}

app.listen(port);
console.log("Server listening on port : " + port);
