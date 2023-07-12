const express = require('express');
const app = express();
const port = 3000;

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

// Start the server
app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});
