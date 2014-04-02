var webcomicat = angular.module('webcomicat',[]);

//for dev
webcomicat.config(function ( $httpProvider) {        
    delete $httpProvider.defaults.headers.common['X-Requested-With'];
})

webcomicat.service('comicPageService', ['$rootScope', '$http',
    function($rootScope, $http){
        return {
            getAllComics: function(){
                console.log("Getting...")
                $http.get('http://localhost:8080/webcomicat/comicPage/getAllComicPages')
                    .success(function(data, status, headers, config){
                        $rootScope.$broadcast('gotAllComicPages', data);
                    })
                    .error(function(data, status, headers, config){
                        console.log(status)
                    });
            }
        }
    }
]);

webcomicat.controller("comicController", ['$scope', 'comicPageService',
    function($scope, comicPageService){
        comicPageService.getAllComics();
        
        $scope.$on('gotAllComicPages', function(event, comicPages){
            console.log(comicPages)
        })
    }]
);
