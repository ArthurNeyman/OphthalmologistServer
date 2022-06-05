require('dotenv').config();

//Подключение express
const express = require("express");

const sequelize = require("./db");
const models = require("./models/models");
const cors = require("cors");
const cookieParser = require("cookie-parser");
const router = require("./routes/index");
const errorHandler = require("./middleware/ErrorHandlingMiddleware");
const path = require("path");
const init = require("./init-app");

const PORT = process.env.PORT || 8080;
const app = express();

app.use(cors());
app.use(express.json());
app.use(cookieParser());
app.use(express.static(path.resolve(__dirname, "public")));
app.use("/api", router);
// app.use(express.static("public")); 
// app.use("/img", express.static("img"));

//обработка ошибок - объявляется самым последним
app.use(errorHandler)
const start = async() => {
    try {
        await sequelize.authenticate();
        await sequelize.sync();
        app.listen(PORT, () => {
            console.log("Serv start");
        });
        init();
    } catch (err) {
        console.log("error db ", err);
    }
}

start();