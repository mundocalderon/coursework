    function NarrowItDownController(MenuSearchService) {
        var search = this;
        // $scope.searchTerm = "";
        // ctrl.found = [];

        search.getMatchedMenuItems = function (searchTerm) {
            // console.log(searchTerm);
            search.empty = searchTerm == ("" || undefined)? true : false;
            // search.found = [];
            console.log(search.empty);

            if (!search.empty) {
                var promise = MenuSearchService.getMatchedMenuItems(searchTerm);
                search.found = [];
                console.log(search.found);
                promise.then(function (response) {
                    search.found = response;
                    console.log(search.found.length);
                    search.empty = search.found.length > 0 ? false : true;
                    console.log(search.empty);
                        // console.log(ctrl.found);
                }).catch(function (error) {
                    console.log("error coming back");
                })
            }

        };