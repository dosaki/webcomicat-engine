//This is a javascript file with its top level require directives
//= require jquery
//= require libs/angularjs/angular-1.2.15.js
//= require_tree views
//= require_self

var serverUrl = "http://localhost:8080/"

var webcomicat = angular.module('webcomicat',[]);

//for dev
webcomicat.config(function ( $httpProvider) {
    delete $httpProvider.defaults.headers.common['X-Requested-With'];
})

webcomicat.service('comicPageService', ['$rootScope', '$http',
    function($rootScope, $http){
        return {
            listComicPages: function(){
                $http.get(serverUrl+'comicPage/getAllComicPages')
                    .success(function(data, status, headers, config){
                        $rootScope.$broadcast('gotComicList', data);
                    })
                    .error(function(data, status, headers, config){
                        console.log(status)
                    });
            },
        }
    }
]);

webcomicat.controller("ComicController", ['$scope', 'comicPageService',
    function($scope, comicPageService){
        comicPageService.listComicPages();

        $scope.page = 0;

        $scope.$on('gotComicList', function(event, comicPages){
            $scope.page = comicPages.length - 1;
            $scope.comics = comicPages;
        })
    }]
);
