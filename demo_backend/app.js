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
const bodyParser = require('body-parser');

var contiqueResult;
var monuResult;
var allmonuResult;
var allResult;
var monuqueResult;
var searchingTerm;


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

// Middleware to parse incoming form data
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

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

// Load the comments from the JSON file
function loadComments() {
    const commentsPath = path.join(__dirname, 'comments.json');
    const commentsData = fs.readFileSync(commentsPath, 'utf8');
    return JSON.parse(commentsData);
}

// Save the comments to the JSON file
function saveComments(comments) {
    const commentsPath = path.join(__dirname, 'comments.json');
    fs.writeFileSync(commentsPath, JSON.stringify(comments, null, 2), 'utf8');
}

// Route to handle the contact form submission and save data
app.post('/submitContact', (req, res) => {
    const formData = {
        fullName: req.body['full-name'],
        email: req.body.email,
        phone: req.body.phone,
        subject: req.body.subject,
        message: req.body.msg,
    };

    // Load existing data from the JSON file if it exists
    let existingData = [];

    if (fs.existsSync('user_contact_req.json')) {
        const jsonData = fs.readFileSync('user_contact_req.json', 'utf8');

        if (jsonData) {
            existingData = JSON.parse(jsonData);
        }
    }

    existingData.push(formData);

    // Save the updated data back to the JSON file
    fs.writeFileSync('user_contact_req.json', JSON.stringify(existingData, null, 2));

    // Redirect back to the Contact Us page after submission
    res.redirect('/contact');
});


app.get('/monuments/:monumentName', async (req, res) => {
    const monumentName = req.params.monumentName;
    try {
        // Fetch the monument details based on the name
        const monumentDetails = await fetchMonumentDetailsByName(monumentName);
        if (!monumentDetails) {
            return res.status(404).json({error: 'Monument not found'});
        }

        // Fetch the gallery images for the monument
        const galleryImages = await fetchGalleryImagesByMonumentName(monumentName);

        // Load comments from the JSON file for the specific monument
        const comments = loadCommentsForMonument(monumentName);

        // Render the monument.ejs template with the fetched data
        res.render('monument', {
            monumentDetails,
            galleryImages,
            monuResult,
            contiqueResult,
            allmonuResult,
            allResult,
            monuqueResult,
            comments // Pass the comments to the template
        });
    } catch (error) {
        console.error('Error fetching monument details:', error);
        res.status(500).json({error: 'An error occurred while fetching monument details'});
    }
});

// Define a route to handle gallery pagination
app.get('/gallery/:monumentName/page/:pageNumber', async (req, res) => {
    const monumentName = req.params.monumentName;
    const pageNumber = parseInt(req.params.pageNumber);

    try {
        // Fetch the gallery images for the monument
        const galleryImages = await fetchGalleryImagesByMonumentName(monumentName);

        // Calculate the start and end index for the images on the selected page
        const startIndex = (pageNumber - 1) * 9;
        const endIndex = pageNumber * 9;
        const imagesToShow = galleryImages.slice(startIndex, endIndex);

        // Render the image gallery with the images on the selected page and pass the pageNumber
        res.render('galleryPage', {
            monumentName,
            images: imagesToShow,
            galleryImages,
            monuResult,
            contiqueResult,
            allmonuResult,
            allResult,
            monuqueResult,
            pageNumber // Add pageNumber to the template
        });
    } catch (error) {
        console.error('Error fetching monument details:', error);
        res.status(500).json({ error: 'An error occurred while fetching monument details' });
    }
});

// Route to handle comment submission
app.post('/submit', (req, res) => {
    // Destructure 'name', 'comment', and 'monumentName' from req.body
    const {name, comment, monumentName} = req.body;

    // Load existing comments from the JSON file
    const comments = loadComments();

    // Add the new comment to the comments array
    comments.push({name, comment, monumentName});

    // Save the updated comments back to the JSON file
    saveComments(comments);

    // Redirect back to the monument page after submission
    res.redirect(`/monuments/${monumentName}`);
});

function loadCommentsForMonument(monumentName) {
    // Load all comments from the JSON file
    const allComments = loadComments();

    // Filter and return comments for the specific monument
    return allComments.filter((comment) => comment.monumentName === monumentName);
}

// Endpoint to handle the newsletter subscription form submission
app.post('/subscribe', (req, res) => {
    const { email } = req.body;

    if (!email) {
        return res.status(400).json({ error: 'Email is required.' });
    }

    // Save the email to a JSON file
    fs.readFile('user_newsletter_email.json', 'utf8', (err, data) => {
        if (err) {
            // If the file doesn't exist, create a new array
            const emails = [email];
            fs.writeFile('user_newsletter_email.json', JSON.stringify(emails), 'utf8', (err) => {
                if (err) {
                    console.error('Error writing to the file:', err);
                }
                console.log('Email added and file created.');
                res.redirect('/home'); // Redirect to the home page after successful subscription
            });
        } else {
            // If the file exists, append the new email to the array
            const emails = JSON.parse(data);
            emails.push(email);
            fs.writeFile('user_newsletter_email.json', JSON.stringify(emails), 'utf8', (err) => {
                if (err) {
                    console.error('Error writing to the file:', err);
                }
                console.log('Email added to the file.');
                res.redirect('/home'); // Redirect to the home page after successful subscription
            });
        }
    });
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

        res.render("monument", {monumentDetails: {name: monumentName}, galleryImages: galleryImagesWithRoute});
    });
});

// Route to handle search form submission
app.get('/searchResult', (req, res) => {
    const searchTerm = req.query.term; // Get the search term from the query parameters
    const page = parseInt(req.query.page) || 1; // Get the page number from the query parameters (default to 1)
    const itemsPerPage = 9; // Number of items to display per page
    const offset = (page - 1) * itemsPerPage; // Calculate the offset to determine the starting row for pagination

    const query = `SELECT m.*, c.name AS continentName
                   FROM monuments AS m
                   LEFT JOIN countries AS co ON m.country_id = co.id
                   LEFT JOIN continents AS c ON co.continent_id = c.id
                   WHERE m.name LIKE ? OR c.name LIKE ? OR co.name LIKE ?
                   LIMIT ? OFFSET ?`; // Add LIMIT and OFFSET for pagination

    const searchValue = `%${searchTerm}%`; // Add '%' at the beginning and end to match any substring

    connection.query(query, [searchValue, searchValue, searchValue, itemsPerPage, offset], (error, results) => {
        if (error) {
            console.error('Error executing query:', error);
            res.status(500).json({ error: 'Internal server error' });
        } else {
            // Perform a count query to get the total number of search results
            const countQuery = `SELECT COUNT(*) as total FROM monuments AS m
                                LEFT JOIN countries AS co ON m.country_id = co.id
                                LEFT JOIN continents AS c ON co.continent_id = c.id
                                WHERE m.name LIKE ? OR c.name LIKE ? OR co.name LIKE ?`;

            connection.query(countQuery, [searchValue, searchValue, searchValue], (error, countResults) => {
                if (error) {
                    console.error('Error executing count query:', error);
                    res.status(500).json({ error: 'Internal server error' });
                } else {
                    const totalItems = countResults[0].total;
                    const pageCount = Math.ceil(totalItems / itemsPerPage); // Calculate the total number of pages

                    // Render the searchResult.ejs template with the search results and pagination values
                    res.render('searchResult', {
                        count: totalItems,
                        monuments: results,
                        searchingTerm: searchTerm,
                        pageCount: pageCount,
                        currentPage: page,
                        monuResult,
                        contiqueResult,
                        allmonuResult,
                        allResult,
                        monuqueResult
                    });
                }
            });
        }
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

// Define a route for each continent based on the continent name
app.get('/continents/:continentName', async (req, res) => {
    const continentName = req.params.continentName;

    try {
        // Check if the continent exists in the database
        const continentQuery = 'SELECT * FROM continents WHERE name = ?';
        connection.query(continentQuery, [continentName], async (error, results) => {
            if (error) {
                console.error('Error fetching continent details:', error);
                return res.status(500).json({ error: 'An error occurred while fetching continent details' });
            }

            if (results.length === 0) {
                // Continent not found, render the "invalidContinent.ejs" template
                return res.status(404).render('invalidContinent');
            }

            // Fetch the monuments belonging to the continent based on the continent ID
            const continentId = results[0].ID;
            const monumentsQuery = `SELECT m.*, cn.name AS continentName, cn.cover AS continentCover
                                    FROM monuments AS m
                                    INNER JOIN countries AS c ON m.country_id = c.id
                                    INNER JOIN continents AS cn ON c.continent_id = cn.id
                                    WHERE cn.name = ?`;

            connection.query(monumentsQuery, [continentName], (error, monuments) => {
                if (error) {
                    console.error('Error fetching monuments:', error);
                    return res.status(500).json({ error: 'An error occurred while fetching monuments' });
                }

                if (monuments.length === 0) {
                    // No monuments found for the continent
                    // Render the "continent.ejs" template with an empty array as continentResult
                    return res.render('continent', { continentResult: [], contiqueResult, monuResult, allmonuResult, allResult });
                }

                // Pass the monuments to the "continent.ejs" template
                res.render('continent', { continentResult: monuments, contiqueResult, monuResult, allmonuResult, allResult });
            });
        });
    } catch (error) {
        console.error('Error fetching continent details:', error);
        res.status(500).json({ error: 'An error occurred while fetching continent details' });
    }
});

// Define a route to handle invalid continent names
app.get('/continents/*', (req, res) => {
    res.render('invalidContinent');
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
            return res.status(404).json({error: 'Monument not found'});
        }

        // Create a new PDF document
        const pdfDoc = new PDFDocument();

        // Pipe the PDF document to the response stream to initiate the download
        res.setHeader('Content-Disposition', `attachment; filename="${monumentName}.pdf"`);
        pdfDoc.pipe(res);

        // Add the monument details to the PDF
        pdfDoc.fontSize(20).text(monumentName, {align: 'center'});
        pdfDoc.fontSize(12).text(monumentDescription.description);

        // Finalize the PDF
        pdfDoc.end();
    } catch (error) {
        console.error('Error fetching monument details:', error);
        res.status(500).json({error: 'An error occurred while fetching monument details'});
    }
});

app.get('/search', (req, res) => {
    const searchTerm = req.query.term; // Get the search term from the query parameters
    const query = 'SELECT * FROM monuments WHERE name LIKE ?'; // Use LIKE to perform a partial match search
    const searchValue = `%${searchTerm}%`; // Add '%' at the beginning and end to match any substring

    connection.query(query, [searchValue], (error, results) => {
        if (error) {
            console.error('Error executing query:', error);
            res.status(500).json({error: 'Internal server error'});
        } else {
            // Send the search results as a JSON response
            res.json(results);
        }
    });
});

// Serve static files
app.use(express.static(__dirname + '/public'));

// Load the comments from the JSON file
function loadComments() {
    const commentsPath = path.join(__dirname, 'comments.json');
    const commentsData = fs.readFileSync(commentsPath, 'utf8');
    return JSON.parse(commentsData);
}

// Save the comments to the JSON file
function saveComments(comments) {
    const commentsPath = path.join(__dirname, 'comments.json');
    fs.writeFileSync(commentsPath, JSON.stringify(comments, null, 2), 'utf8');
}

// Define a route for the About Us page
app.get('/about', (req, res) => {
    res.render('About_Us', {monuResult, contiqueResult, allmonuResult, allResult, monuqueResult});
});

// Define a route for the Contact Us page
app.get('/contact', (req, res) => {
    res.render('Contact_Us', {monuResult, contiqueResult, allmonuResult, allResult, monuqueResult});
});

app.get('/test', (req, res) => {
    res.render('layout/NavBar', {monuResult, contiqueResult, allmonuResult, allResult, monuqueResult});
});

app.get('/monudb', (req, res) => {
    res.render('monument', {monuResult, contiqueResult, allmonuResult, allResult, monuqueResult});
});

//Define a route for the Home page for /home and /
const route_home = ['/home', ''];
app.get(route_home, (req, res) => {
    res.render('Homepage', {contiqueResult, monuResult, allmonuResult, allResult});
});

// Route handler for /all with pagination
app.get('/all', (req, res) => {
    const itemsPerPage = 9;
    const currentPage = parseInt(req.query.page) || 1; // Get the current page from the query parameter, default to page 1 if not provided

    // Calculate the offset to fetch the monuments for the current page
    const offset = (currentPage - 1) * itemsPerPage;

    // SQL query to fetch the monuments for the current page with pagination
    const query = `SELECT *
                   FROM monuments
                   ORDER BY ID
                   LIMIT ? OFFSET ?`;

    // Execute the SQL query with pagination parameters
    connection.query(query, [itemsPerPage, offset], (error, results) => {
        if (error) {
            console.error('Error executing query:', error);
            res.status(500).json({ error: 'Internal server error' });
        } else {
            // Fetch the total number of monuments to calculate the total number of pages
            const totalMonumentsQuery = 'SELECT COUNT(*) AS totalCount FROM monuments';
            connection.query(totalMonumentsQuery, (error, totalCountResult) => {
                if (error) {
                    console.error('Error executing totalMonumentsQuery:', error);
                    res.status(500).json({ error: 'Internal server error' });
                } else {
                    const totalMonuments = totalCountResult[0].totalCount;
                    const pageCount = Math.ceil(totalMonuments / itemsPerPage);

                    // Render the All_Destination.ejs template with the monuments and pagination data
                    res.render('All_Destination', {
                        monuResult,
                        contiqueResult,
                        allmonuResult,
                        allResult: results, // Pass the fetched monuments for the current page
                        currentPage,
                        pageCount,
                    });
                }
            });
        }
    });
});

// Start the server
app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});
