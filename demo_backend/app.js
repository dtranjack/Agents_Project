const express = require('express');
const mysql = require('mysql');
const app = express();
const port = 3000;

var contiqueResult;
var monuResult;
var allmonuResult;
var allResult;

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
    } else {
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

const monumentIDs = [1, 11, 5];
const gimmeAllMonuInfos = `SELECT * FROM monument WHERE ID IN (${monumentIDs.join(',')}) LIMIT 3`;

connection.query(gimmeAllMonuInfos, (error, results) => {
    if (error) {
        console.error('Error executing query:', error);
        // Handle the error accordingly
    } else {
        // Assign the query result to a different variable
        allmonuResult = results;
        console.log(allmonuResult);
        // Now you can use the variable to access the query result
    }
});

const allMonu = `SELECT * FROM monument`;

connection.query(allMonu, (error, results) => {
    if (error) {
        console.error('Error executing query', error);
    } else {
        allResult = results;
        console.log(allResult)
    }
});

app.get('/continents', (req, res) => {
    // Perform the database query to fetch continents data
    const getContinentsQuery = 'SELECT * FROM continents';
    connection.query(getContinentsQuery, (error, results) => {
        if (error) {
            console.error('Error executing query:', error);
            res.status(500).json({error: 'Internal server error'});
        } else {
            // Send the continents data as a JSON response
            res.json(results);
        }
    });
});

app.get('/monuments/:continentId', (req, res) => {
  const continentId = req.params.continentId;
  const query = `SELECT m.* FROM monument AS m
                 INNER JOIN countries AS c ON m.country_id = c.id
                 WHERE c.continent_id = ?`;
  connection.query(query, [continentId], (error, results) => {
    if (error) {
      console.error('Error fetching monuments:', error);
      // Handle the error accordingly
    } else {
      res.json(results);
    }
  });
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
    res.render('layout/home_All', {monuResult, contiqueResult, allmonuResult, allResult});
});

//Define a route for the Home page for /home and /
const route_home = ['/home', ''];
app.get(route_home, (req, res) => {
    res.render('Homepage', {contiqueResult, monuResult, allmonuResult, allResult});
});

app.get('/all', (req, res) => {
    res.render('All_Destination', {monuResult, contiqueResult, allmonuResult, allResult});
});

// Start the server
app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});
