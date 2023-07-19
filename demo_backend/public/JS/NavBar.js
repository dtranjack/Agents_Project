$(document).ready(function () {
    // Fetch continents data from the server
    jQuery.ajax({
        url: '/continents', // This URL should point to the server endpoint that provides continents data
        method: 'GET',
        dataType: 'json',
        success: function (data) {
            const dropdownMenu = $('#destinationsMenu');
            // Loop through the continents and add them to the dropdown menu
            data.forEach(function (continent) {
                dropdownMenu.append('<a class="dropdown-item" href="#">' + continent.name + '</a>');
            });

            // Enable auto-dropdown on hover
            $('li.dropdown').hover(function() {
                $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeIn(200);
            }, function() {
                $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeOut(200);
            });
        },
        error: function (error) {
            console.error('Error fetching continents:', error);
        },
    });
});
