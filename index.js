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
app.get("/sources/:username", isLoggedIn, function (req, res) {
  // get list sources
  db.query(
    "SELECT * FROM source WHERE userName = ?",
    req.params.username,
    function (err, result) {
      if (err) throw err;
      return res.send(result);
    }
  );
});

app.get("/sources/:id", function (req, res) {
  // get list sources
  let idSource = parseInt(req.params.id);
  db.query(
    "SELECT * FROM source WHERE idSource = ?",
    idSource,
    function (err, result) {
      if (err) throw err;
      return res.send(result);
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
  db.query(
    "UPDATE source SET nameSource = ?, desSource = ?, imageSource=? WHERE idSource = ?",
    [nameSource, desSource, imageSource, idSource],
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
  let idLevel = req.body.idLevel;
  let vocab = req.body.vocab;
  let meaning = req.body.meaning;
  let imageWord = req.files.imageWord[0].filename;
  let audioWord = req.files.audioWord[0].filename;
  db.query(
    "INSERT INTO word SET  idLevel = ?, vocab = ?, meaning = ?, imageWord= ?,audioWord=?",
    [idLevel, vocab, meaning, imageWord, audioWord],
    function (err, result) {
      if (err) throw err;
      res.send("create success");
    }
  );
});

app.put("/words/:id", uploadMultiple, function (req, res) {
  //update word
  let id = parseInt(req.params.id);
  let idLevel = req.body.idLevel;
  let vocab = req.body.vocab;
  let meaning = req.body.meaning;
  let imageWord = req.files.imageWord[0].filename;
  let audioWord = req.files.audioWord[0].filename;
  db.query(
    "UPDATE word SET idLevel = ? , vocab = ? , meaning = ? , imageWord = ? , audioWord = ? WHERE id = ?",
    [idLevel, vocab, meaning, imageWord, audioWord, id],
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
  db.query(
    "SELECT * FROM level WHERE idSource = ?",
    idSource,
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
  db.query(
    "INSERT INTO level SET  level = ? , idSource = ?, imageLevel=? ",
    [level, idSource, imageLevel],
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
  let idLevel = parseInt(req.params.id);
  db.query(
    "UPDATE level SET level = ?, idSource = ? , imageLevel= ?WHERE idLevel = ?",
    [level, idSource, imageLevel, idLevel],
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

app.get("/users", function (req, res) {
  db.query("SELECT * FROM user ", function (err, results) {
    if (err) throw err;
    return res.send(results);
  });
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
            throw bErr;
            return res
              .status(401)
              .send({ message: "Username or password is incorrect" });
          }
          if (bResults) {
            const token = jwt.sign(
              { userName: results[0].userName, userId: results[0].userId },
              "SECRETKEY",
              { expiresIn: "1h" }
            );
            return res.status(200).send(token);
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
      return res.send(req.file.filename);
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
