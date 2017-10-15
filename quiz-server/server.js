const express = require('express')
const ip = require('ip');
const path = require('path');
const colors = require('colors');

const app = express();

app.use('/css', express.static('public/css'))

app.get("/quiz", function(req, res) {
    console.log(colors.grey("Start connection: " + req.hostname));
    res.sendFile(path.join(__dirname + '/public/quiz.html'));
});

var port = process.env.PORT || 3000;

app.listen(port, function () {

    let url = ("http://" + ip.address().bold + ":" + port.toString().green + "/")
    console.log("Server running at " + url.underline);
    console.log("Quiz URL: " + (url + "quiz/").underline.bold);
});

process.on('SIGINT', function () {
    console.log("SIGINT".underline.red + " recieved, process exiting.");
    process.exit();
});

process.on('SIGTERM', function () {
    console.log("SIGTERM".underline.red + " recieved, process exiting.");
    process.exit();
});
