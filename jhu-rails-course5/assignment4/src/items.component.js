(function () {
'use strict';

angular.module('MenuApp')
.component('items', {
  templateUrl: 'src/templates/itemslist.template.html',
  bindings: {
    items: '<'
  }
});


})();