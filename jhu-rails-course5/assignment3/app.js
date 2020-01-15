(function () { 
'use strict';

angular.module('NarrowItDownApp', [])
.controller('NarrowItDownController', NarrowItDownController)
.service('MenuSearchService', MenuSearchService)
.directive('foundItems', FoundItems);

function FoundItems(){
	var ddo = {
		restrict: 'E',
		templateUrl: "foundItem.html",
		scope: { 
			foundItems: '<',
			onRemove: '&',
			isEmpty: '<'
		}
	};
	return ddo;
};

NarrowItDownController.$inject = ['MenuSearchService'];
function NarrowItDownController(MenuSearchService){
	var list = this;
	
	var empty = false;
	list.searchTerm = "";
	list.found = [];


	list.find = function(searchTerm){
		if (list.searchTerm == "") {
			list.empty = true;
			list.found = [];
		} 
		else {
			var promise = MenuSearchService.getMatchedMenuItems(searchTerm);
			promise.then(function (response){
				list.found = response;
				list.empty = list.found.length > 0 ? false : true;
			}).catch(function(error){
				console.log("error fulfilling promise!");
			})
		}
	}

	list.removeItem = function(index){
		return list.found.splice(index,1);
	}

};

MenuSearchService.$inject = ['$http'];
function MenuSearchService($http) {
	var service = this;

	service.getMatchedMenuItems = function (searchTerm){
		var foundItems = [];

		searchTerm = searchTerm.toLowerCase();

		return $http({url: ("https://davids-restaurant.herokuapp.com/menu_items.json")})
		.then(function (response){
			for ( var i = 0; i < response.data.menu_items.length; i++) {
				if (response.data.menu_items[i].description.toLowerCase().indexOf(searchTerm) !== -1){
					foundItems.push(response.data.menu_items[i]);
				}
			}
			return foundItems;
		})
		.catch(function (error){
			console.log("Error while retrieving the data.");
		});
	};	
};

})();