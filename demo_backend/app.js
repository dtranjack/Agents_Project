const mysql = require('mysql');
const express = require('express');
const ejs = require('ejs');
const app = express();

// Serve static files from the "public" directory
app.use(express.static(__dirname + '/public'));
app.set('view engine', 'ejs');

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root', //change user to your user
    password: '171198', //change password to your password
    database: 'monument' //change database to your database name
});

app.get('/', (req, res) => {
    const query = 'SELECT * FROM `monuments` WHERE (`monuments`.`ID` = 1)';
    connection.query(query, (error, results) => {
        if (error) {
            console.error('Error executing query: ', error);
            return;
        }

        console.log('Query results:', results);
        // Render the index.ejs template with the query results
        res.render('TestEJS', { results: results });
    });
});

app.listen(3000, () => {
    console.log('Server listening on port 3000');
});
