console.log('AngularJS script executed.');

angular.module('myApp', ['ngSanitize'])
  .controller('DropdownController', function($scope, $http, $sce) {
    console.log('DropdownController initialized.');
    $scope.continents = [];

    // Fetch continents and monuments
    $http.get('/continents')
      .then(function(response) {
        $scope.continents = response.data;

        loadNestedMenu();
      })
      .catch(function(error) {
        console.error('Error fetching continents:', error);
        // Handle the error accordingly
      });

    function loadNestedMenu() {
      $scope.continents.forEach(function(continent) {
        $http.get('/monuments/' + continent.id)
          .then(function(response) {
            var monuments = response.data;

            continent.monuments = monuments;
          })
          .catch(function(error) {
            console.error('Error fetching monuments:', error);
            // Handle the error accordingly
          });
      });
    }

    $scope.showSubmenu = function(event) {
      event.preventDefault();
      event.stopPropagation();
    };
  });
