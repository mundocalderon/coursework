(function (){ 
'use strict';

angular.module('ShoppingListCheckOff', [])
.controller('ToBuyController', ToBuyController)
.controller('AlreadyBoughtController', AlreadyBoughtController)
.service('ShoppingListCheckOffService', ShoppingListCheckOffService);

ToBuyController.$inject = ['ShoppingListCheckOffService'];
function ToBuyController(ShoppingListCheckOffService){
	var toBuyList = this;

	toBuyList.toBuyItems = ShoppingListCheckOffService.getBuyItems();

	toBuyList.buyCheckOff = function (itemIndex) {
		ShoppingListCheckOffService.checkOff(itemIndex)
	};

}

AlreadyBoughtController.$inject = ['ShoppingListCheckOffService'];
function AlreadyBoughtController(ShoppingListCheckOffService){
	var boughtList = this;

	boughtList.boughtItems = ShoppingListCheckOffService.getBoughtItems();

}

function ShoppingListCheckOffService() {
	var service = this;

	var buyItems = [
		{
			name: "Milk",
			quantity: "2"
		},
		{
			name: "Donuts",
			quantity: "200"
		},
		{
			name: "Cookies",
			quantity: "30"
		},
		{
			name: "Chocolates",
			quantity: "20"
		},
		{
			name: "Socks",
			quantity: "12"
		}
	];

	var boughtItems = [];

	service.getBuyItems = function () {
		return buyItems;
	};

	service.getBoughtItems = function() {
		return boughtItems;
	};

	service.checkOff = function(itemIndex) {
		boughtItems.push(buyItems[itemIndex]);
		buyItems.splice(itemIndex, 1);
	};
}

})();