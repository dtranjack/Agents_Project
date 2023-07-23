$(document).ready(function() {
  // Fetch continents and populate the continent menu
  $.ajax({
    url: '/continents',
    type: 'GET',
    success: function(data) {
      const continentMenu = $('#destinationsMenu');
      continentMenu.empty();

      data.forEach(function(continent) {
        const continentItem = $('<a>').addClass('dropdown-item continent')
          .attr('href', '#')
          .attr('data-continent-id', continent.id)
          .text(continent.name);

        const monumentMenu = $('<ul>').addClass('dropdown-menu');
        const continentWrapper = $('<li>').addClass('dropdown-submenu')
          .append(continentItem)
          .append(monumentMenu);

        continentMenu.append(continentWrapper);
      });

      // Load the click event handling for continent menu items
      loadContinentClickEvent();
    },
    error: function(error) {
      console.error('Error fetching continents:', error);
      // Handle the error accordingly
    }
  });
});

function loadContinentClickEvent() {
  // Handle click event on continent menu items
  $(document).on('click', '.continent', function() {
    const continentId = $(this).data('continent-id');
    const monumentMenu = $(this).siblings('.dropdown-menu');

    // Clear existing monument options
    monumentMenu.empty();

    // Fetch monuments based on the selected continent
    $.ajax({
      url: `/monuments/${continentId}`,
      type: 'GET',
      success: function(data) {
        if (data.length === 0) {
          monumentMenu.append('<li><a class="dropdown-item" href="#">No monuments</a></li>');
        } else {
          data.forEach(function(monument) {
            console.log('Adding new item to submenu')
            monumentMenu.append(`<li><a class="dropdown-item" href="#">${monument.name}</a></li>`);
          });
        }
      },
      error: function(error) {
        console.error('Error fetching monuments:', error);
        // Handle the error accordingly
      }
    });
  });
}
