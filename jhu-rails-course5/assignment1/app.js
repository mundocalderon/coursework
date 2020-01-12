(function (){ 
'use strict';

angular.module('LunchCheck', [])
.controller('LunchCheckController', LunchCheckController);

LunchCheckController.$inject = ['$scope'];
function LunchCheckController($scope) { 
	$scope.lunchInput = "";
	$scope.lunchOutput = "";

	$scope.lunchCheck = function () {
		console.log('in lunchcehck')
		if ($scope.lunchInput === "" ) { 
			console.log('Please enter data first!');
			$scope.lunchOutput = 'Please enter data first';
			$scope.status = 'text-danger'
			$scope.validity = 'has-error'

		}
		else if ($scope.lunchInput.split(',').length < 4) {
			console.log('Enjoy!');
			$scope.lunchOutput = 'Enjoy';
			$scope.status = 'text-success'
			$scope.validity = 'has-success'


		}
		else if ($scope.lunchInput.split(',').length > 3 ){
			console.log('Too Much!');
			$scope.lunchOutput = "Too Much!"
			$scope.status = 'text-success'
			$scope.validity = 'hass-success'

		}
		console.log($scope.lunchInput)
	};
};

})();