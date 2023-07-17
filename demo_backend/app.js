const express = require('express');
const mysql = require('mysql');
const app = express();
const port = 3000;

var contiqueResult;
var monuResult;

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '171198',
    database: 'monument',
});

connection.connect((err) => {
    if (err) {
        console.error('Error connecting to the database:', err);
        return;
    }
    console.log('Connected to the database!');
});

const gimmeContiInfos = 'SELECT * FROM continents';
connection.query(gimmeContiInfos, (error, results) => {
    if (error) {
        console.error('Error executing query:', error);
        // Handle the error accordingly
    }
    else {
        // Assign the query result to a different variable
        contiqueResult = results;
        console.log(contiqueResult);
        // Now you can use the variable to access the query result
    }
});

const gimmeMonuInfos = 'SELECT * FROM monument WHERE name IN (\'Halong Bay\', \'Colosseum\', \'Machu Picchu\')';

connection.query(gimmeMonuInfos, (error, results) => {
    if (error) {
        console.error('Error executing query:', error);
        // Handle the error accordingly
    } else {
        // Assign the query result to a different variable
        monuResult = results;
        console.log(monuResult);
        // Now you can use the variable to access the query result
    }
});


// Set the view engine to EJS
app.set('view engine', 'ejs');

// Serve static files
app.use(express.static(__dirname + '/public'));

// Define a route for the About Us page
app.get('/about', (req, res) => {
    res.render('About_Us');
});

// Define a route for the Contact Us page
app.get('/contact', (req, res) => {
    res.render('Contact_Us');
});

app.get('/test', (req, res) => {
    res.render('layout/home_OurRec', {monuResult});
});

//Define a route for the Home page for /home and /
const route_home=['/home', ''];
app.get(route_home, (req,res) => {
    res.render('Homepage', {contiqueResult, monuResult});
});

// Start the server
app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});
