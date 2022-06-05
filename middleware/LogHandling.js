const fs = require("fs");
const moment = require("moment");

class LogHandling {
    writeLog(err) {
        fs.appendFile(__dirname + "/../logs/log.txt", err + " " + moment().format("YYYY-MM-DD HH:mm:ss") + " \n", function(error){
            if(error) throw error; // если возникла ошибка
        });
    }
}

module.exports = new LogHandling();