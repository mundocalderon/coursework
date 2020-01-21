(function () {
'use strict';

angular.module('MenuApp')
.component('categories', {
  templateUrl: 'src/templates/categorieslist.template.html',
  bindings: {
    items: '<'
  }
});

})();