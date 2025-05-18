const path = require('path');
const express = require('express');
const OS = require('os');
const bodyParser = require('body-parser');
const mongoose = require("mongoose");
const app = express();
const cors = require('cors')


app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, '/')));
app.use(cors())

mongoose.connect(process.env.MONGO_URI, {
    user: process.env.MONGO_USERNAME,
    pass: process.env.MONGO_PASSWORD
})
.then(() => {
    // console.log("MongoDB Connection Successful");
})
.catch((err) => {
    console.log("error!! " + err);
});

var Schema = mongoose.Schema;

var dataSchema = new Schema({
    name: String,
    id: Number,
    description: String,
    image: String,
    velocity: String,
    distance: String
});
var planetModel = mongoose.model('planets', dataSchema);



app.post('/planet', async function(req, res) {
    const planetId = req.body.id;
    console.log("Received Planet ID:", planetId);

    try {
        const planetData = await planetModel.findOne({ id: planetId });

        if (!planetData) {
            console.log("No planet found with ID:", planetId);
            return res.status(404).send("Ooops, we only have 9 planets and a sun. Select a number from 0 - 9.");
        }

        console.log("Planet data found:", planetData);
        res.send(planetData);
    } catch (err) {
        console.error("Database error while fetching planet:", err);
        res.status(500).send("Error in Planet Data");
    }
});

app.get('/',   async (req, res) => {
    res.sendFile(path.join(__dirname, '/', 'index.html'));
});


app.get('/os',   function(req, res) {
    res.setHeader('Content-Type', 'application/json');
    res.send({
        "os": OS.hostname(),
        "env": process.env.NODE_ENV
    });
})

app.get('/live',   function(req, res) {
    res.setHeader('Content-Type', 'application/json');
    res.send({
        "status": "live"
    });
})

app.get('/ready',   function(req, res) {
    res.setHeader('Content-Type', 'application/json');
    res.send({
        "status": "ready"
    });
})

app.listen(3000, () => {
    console.log("Server successfully running on port - " +3000);
})


module.exports = app;