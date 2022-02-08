const express = require("express");
//const morgan = require('morgan');
const client = require('./db.js');

const app = express();

const init = async() => {
    try {
        await client.connect();
        console.log('connected ...');
        // const sql = ``;
        //const sql = require('./seed.sql');
        //await client.query(sql);
        //console.log('data is seeded ...');
        const PORT = process.env.PORT || 3000;
        app.listen(PORT, () => console.log(`App listening in port ${PORT}`));
    }
    catch (err) {
        console.log(err);
    }
}

init();

app.get('/', async(req, res, next) => {
    try {
        const sql = `SELECT * FROM rankings`;
        const response = await client.query(sql);
        const players = response.rows;
        //console.log(players);

        const html = `
        <html>
            <head>
                <title>ATP Rankings</title>
                <style>
                    td {
                        text-align: center;
                    }
                </style>
            </head>
            <body>
                <h1>ATP Rankings</h1>
                <table style="width:50%">
                    <tr>
                        <th>Ranking</th>
                        <th>Country</th>
                        <th>Player</th>
                        <th>Age</th>
                        <th>Points</th>
                    </tr>
                    ${players.map(player => `
                        <tr>
                            <td>${player.ranking}</td>
                            <td>${player.country}</td>
                            <td><a href='/players/${player.id}'>${player.name}</a></td>
                            <td>${player.age}</td>
                            <td>${player.point}</td>
                        </tr>
                    `).join('')}
                </table>
            </body>
        </html>
        `;
        //console.log(html);
        res.send(html);
    }
    catch (err) {
        next(err);
    }
});

app.get('/players/:id', async(req, res, next) => {
    try {
        const sql = `SELECT rks.name, rks.ranking, players.ageDate, players.weight, players.height, players.birthplace, players.plays, players.coach FROM players JOIN rankings AS rks ON players.rankingId = rks.ranking WHERE players.id = $1`;
        const response = await client.query(sql, [req.params.id]);
        const player = response.rows[0];
        //console.log(players);

        const html = `
        <html>
            <head>
                <title>ATP Rankings</title>
                <style>
                    h1 span {
                        color: white;
                        background-color: dodgerBlue;
                    }
                </style>
            </head>
            <body>
                <h2>Player's ATP Ranking</h2> <p><a href='/'>Go Back</a></p> 
                <h1><span>${player.name}</span></h1>
                <h2>Ranking ${player.ranking}</h2>
                <p><font size="+1"><b>Age</b></font>: ${player.agedate}</p>
                <p><font size="+1"><b>Weight</b></font>: ${player.weight}</p>
                <p><font size="+1"><b>Height</b></font>: ${player.height}</p>
                <p><font size="+1"><b>Birthplace</b></font>: ${player.birthplace}</p>
                <p><font size="+1"><b>Plays</b></font>: ${player.plays}</p>
                <p><font size="+1"><b>Coach</b></font>: ${player.coach}</p>
            </body>
        </html>
        `;
        //console.log(html);
        res.send(html);
    }
    catch (err) {
        next(err);
    }
});

