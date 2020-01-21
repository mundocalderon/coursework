(function () {
'use strict';

angular.module('MenuApp')
.config(RoutesConfig);

RoutesConfig.$inject = ['$stateProvider', '$urlRouterProvider'];
function RoutesConfig($stateProvider, $urlRouterProvider){

	$urlRouterProvider.otherwise('/');
	$stateProvider

	.state('home', {
		url: '/',
		templateUrl: 'src/templates/home.template.html'
	})

	.state('categoriesList', {
		url: '/categories',
		templateUrl: 'src/templates/categories.template.html',
		controller: 'CategoriesListController as categoriesList',
		resolve: {
			categories: ['MenuDataService', function (MenuDataService){
				return MenuDataService.getAllCategories();
			}]
		}
	})

	.state('itemsList', {
		url: '/items/{itemsListId}',
		templateUrl: 'src/templates/items.template.html',
		controller: 'ItemsListController as itemsList',
		resolve: {
			items: ['MenuDataService', '$stateParams', function (MenuDataService, $stateParams){
				return MenuDataService.getItemsForCategory($stateParams.itemsListId);
			}]
		}

	})

}

})();