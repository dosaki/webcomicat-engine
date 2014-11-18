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
                $http.get(serverUrl+'manageComic/getAllComicPages')
                    .success(function(data, status, headers, config){
                        $rootScope.$broadcast('gotComicList', data);
                    })
                    .error(function(data, status, headers, config){
                        console.log(status)
                    });
            },
            createNewComicPage: function(comicPage){
                var fd = new FormData();
                //Take the first selected file
                fd.append("file", comicPage.image);
                fd.append("data", angular.toJson(comicPage));

                $http.post(serverUrl+'manageComic/newComicPage', fd, {
                    headers: {'Content-Type': undefined },
                    transformRequest: angular.identity
                })
                .success(function(data, status, headers, config){
                    $rootScope.$broadcast('gotNewPage', data);
                })
                .error(function(data, status, headers, config){
                    $rootScope.$broadcast('error', data);
                });
            },
            deleteComicPage: function(id){
                $http.post(serverUrl+'manageComic/deleteComicPage', {'id':id})
                    .success(function(data, status, headers, config){
                        $rootScope.$broadcast('deletedComicPage', data);
                    })
                    .error(function(data, status, headers, config){
                        $rootScope.$broadcast('error', data);
                    });
            },
        }
    }
]);
webcomicat.service('chapterService', ['$rootScope', '$http',
    function($rootScope, $http){
        return {
            listChapters: function(){
                $http.get(serverUrl+'manageComic/getAllChapters')
                    .success(function(data, status, headers, config){
                        $rootScope.$broadcast('gotChapters', data);
                    })
                    .error(function(data, status, headers, config){
                        console.log(status)
                    });
            },
            createNewChapter: function(chapter){
                $http.post(serverUrl+'manageComic/newChapter', chapter)
                    .success(function(data, status, headers, config){
                        $rootScope.$broadcast('gotNewChapter', data);
                    })
                    .error(function(data, status, headers, config){
                        $rootScope.$broadcast('error', data);
                    });
            },
        }
    }
]);

webcomicat.controller("AdminController", ['$scope', 'comicPageService', 'chapterService',
    function($scope, comicPageService, chapterService){
        comicPageService.listComicPages();
        chapterService.listChapters();

        $scope.newChapter = {
            title:"",
            sequence:""
        }
        $scope.newComicPage = {
            title:null,
            image:null,
            description:null,
            chapter:null
        }
        $scope.feedbackMsg = {
            text:"",
            type:"invisible"
        }

        /* Functions */
        $scope.listChapters = function(){
            chapterService.listChapters();
        }
        $scope.createNewChapter = function(chapt){
            chapterService.createNewChapter(chapt);
        }
        $scope.listComics = function(){
            comicPageService.listComicPages();
        }
        $scope.createNewComicPage = function(){
            comicPageService.createNewComicPage($scope.newComicPage);
        }
        $scope.deleteComicPage = function(id){
            comicPageService.deleteComicPage(id);
        }
        $scope.updateNewComicChapt = function(chapt){
            $scope.newComicPage.chapter = chapt
        }
        $scope.updateNewComicImg = function(files){
            $scope.newComicPage.image = files[0]
        }

        /* Listeners */
        $scope.$on('gotComicList', function(event, comicList){
            $scope.comics = comicList;
        })
        $scope.$on('gotChapters', function(event, chapters){
            $scope.chapters = chapters;
        })
        $scope.$on('gotNewPage', function(event, comic){
            $scope.comics.push(comic);
            $scope.newComicPage = {
                title:null,
                image:null,
                description:null,
                chapter:null
            }
            $scope.feedbackMsg.text = "Comic Page created";
            $scope.feedbackMsg.type = "alert alert-success alert-dismissible";
            $("#imageInput").val("")
            $("#comicPreview").attr("src", '')
        })
        $scope.$on('gotNewChapter', function(event, chapter){
            $scope.chapters.push(chapter);
            $scope.newChapter.title = ""
            $scope.newChapter.sequence = ""
            $scope.feedbackMsg.text = "Chapter created";
            $scope.feedbackMsg.type = "alert alert-success alert-dismissible";
        })
        $scope.$on('deletedComicPage', function(event,data){
            for(key in $scope.comics){
                if($scope.comics[key].id == data){
                    $scope.comics.splice(key,1)
                    break;
                }
            }
            $scope.feedbackMsg.text = "Comic Page deleted";
            $scope.feedbackMsg.type = "alert alert-success alert-dismissible";
        })
        $scope.$on('error', function(event,data){
            $scope.feedbackMsg.text = data;
            $scope.feedbackMsg.type = "alert alert-danger alert-dismissible";
        })
    }]
);
