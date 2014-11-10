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
            comicList: function(){
                $http.get(serverUrl+'webcomicat/manageComic/getAllComicPages')
                    .success(function(data, status, headers, config){
                        $rootScope.$broadcast('gotComicList', data);
                    })
                    .error(function(data, status, headers, config){
                        console.log(status)
                    });
            },/*
            getAllComics: function(){
                $http.get('http://localhost:8080/webcomicat/comicPage/getAllComicPages')
                    .success(function(data, status, headers, config){
                        $rootScope.$broadcast('gotAllComicPages', data);
                    })
                    .error(function(data, status, headers, config){
                        console.log(status)
                    });
            }*/
        }
    }
]);

webcomicat.controller("AdminController", ['$scope', 'comicPageService',
    function($scope, comicPageService){
        comicPageService.comicList();

        /* Functions */
        $scope.listComics = function(){
            comicPageService.comicList();
        }
        /* Listeners */
        $scope.$on('gotComicList', function(event, comicList){
            $scope.comics = comicList;
        })
    }]
);
/*
webcomicat.controller("comicController", ['$scope', 'comicPageService',
    function($scope, comicPageService){
        comicPageService.getAllComics();

        $scope.$on('gotAllComicPages', function(event, comicPages){
            console.log(comicPages)
        })
    }]
);
*/
