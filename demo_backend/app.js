const express = require('express');
const mysql = require('mysql');
const app = express();
const port = 3000;
const fs = require('fs');
const path = require('path');
const PDFDocument = require('pdfkit');
const ejs = require('ejs');
const pdf = require('html-pdf');
const docxTemplater = require('docxtemplater');

var contiqueResult;
var monuResult;
var allmonuResult;
var allResult;
var monuqueResult;

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

const gimmeMonuInfos = 'SELECT * FROM monuments WHERE name IN (\'Halong Bay\', \'Colosseum\', \'Machu Picchu\')';

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
const gimmeAllMonuInfos = `SELECT *
                           FROM monuments
                           WHERE ID IN (${monumentIDs.join(',')})
                           LIMIT 3`;

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

const allMonu = `SELECT *
                 FROM monuments`;

connection.query(allMonu, (error, results) => {
    if (error) {
        console.error('Error executing query', error);
    } else {
        allResult = results;
        console.log(allResult)
    }
});

app.get('/monuments/:monumentName', async (req, res) => {
    const monumentName = req.params.monumentName;
    try {
        // Fetch the monument details based on the name
        const monumentDetails = await fetchMonumentDetailsByName(monumentName);
        if (!monumentDetails) {
            return res.status(404).json({ error: 'Monument not found' });
        }

        // Fetch the gallery images for the monument
        const galleryImages = await fetchGalleryImagesByMonumentName(monumentName);

        // Render the monument.ejs template with the fetched data
        res.render('monument', { monumentDetails, galleryImages });
    } catch (error) {
        console.error('Error fetching monument details:', error);
        res.status(500).json({ error: 'An error occurred while fetching monument details' });
    }
});

function fetchGalleryImagesByMonumentName(name) {
    return new Promise((resolve, reject) => {
        const query = 'SELECT img_path FROM gallery WHERE name = ?';
        connection.query(query, [name], (error, results) => {
            if (error) {
                reject(error);
            } else {
                // Parse the JSON data in the img_path column and return the array of image paths
                const imagePaths = JSON.parse(results[0].img_path);
                resolve(imagePaths);
            }
        });
    });
}

app.get("/gallery/:monumentName", (req, res) => {
    // Fetch data from MySQL database
    const monumentName = req.params.monumentName;
    const sql = "SELECT img_path FROM gallery WHERE name = ?";
    connection.query(sql, [monumentName], (err, results) => {
        if (err) throw err;
        const galleryImages = JSON.parse(results[0].img_path);

        // Prefix the image paths with the /gallery route
        const galleryImagesWithRoute = galleryImages.map(imagePath => `/gallery${imagePath}`);

        res.render("monument", { monumentDetails: { name: monumentName }, galleryImages: galleryImagesWithRoute });
    });
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
    const query = `SELECT m.*
                   FROM monuments AS m
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

function fetchMonumentDetailsByName(name) {
    return new Promise((resolve, reject) => {
        const query = 'SELECT * FROM monuments WHERE name = ?';
        connection.query(query, [name], (error, results) => {
            if (error) {
                reject(error);
            } else {
                resolve(results[0]);
            }
        });
    });
}

// Define a route to download monument description as PDF
app.get('/download/:monumentName/pdf', async (req, res) => {
    const monumentName = req.params.monumentName;
    try {
        // Fetch the monument description based on the name
        const monumentDescription = await fetchMonumentDetailsByName(monumentName);
        if (!monumentDescription) {
            return res.status(404).json({ error: 'Monument not found' });
        }

        // Create a new PDF document
        const pdfDoc = new PDFDocument();

        // Pipe the PDF document to the response stream to initiate the download
        res.setHeader('Content-Disposition', `attachment; filename="${monumentName}.pdf"`);
        pdfDoc.pipe(res);

        // Add the monument details to the PDF
        pdfDoc.fontSize(20).text(monumentName, { align: 'center' });
        pdfDoc.fontSize(12).text(monumentDescription.description);

        // Finalize the PDF
        pdfDoc.end();
    } catch (error) {
        console.error('Error fetching monument details:', error);
        res.status(500).json({ error: 'An error occurred while fetching monument details' });
    }
});


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
    res.render('monument', {monuResult, contiqueResult, allmonuResult, allResult, monuqueResult});
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
