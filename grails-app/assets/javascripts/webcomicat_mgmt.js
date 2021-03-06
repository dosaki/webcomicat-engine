//This is a javascript file with its top level require directives
//= require jquery
//= require libs/angularjs/angular-1.2.15.js
//= require_tree views
//= require_self

var serverUrl = "/"

var webcomicat = angular.module('webcomicat',[]);

//for dev
webcomicat.config(function ( $httpProvider) {
    delete $httpProvider.defaults.headers.common['X-Requested-With'];
})

webcomicat.service('generalService', ['$rootScope', '$http',
    function($rootScope, $http){
        return {
            getSettings: function(){
                $http.get(serverUrl+'manageComic/getSettings')
                    .success(function(data, status, headers, config){
                        $rootScope.$broadcast('gotSettings', data);
                    })
                    .error(function(data, status, headers, config){
                        console.log(status)
                    });
            },
            saveSettings: function(settings, images){
                console.log(images)
                if(images && images.favicon){
                    this.uploadImage(images.favicon,"favicon");
                }
                if(images && images.profileImage){
                    this.uploadImage(images.profileImage,"profileImage");
                }
                $http.post(serverUrl+'manageComic/saveSettings', settings)
                    .success(function(data, status, headers, config){
                        $rootScope.$broadcast('settingsSaved', data);
                    })
                    .error(function(data, status, headers, config){
                        console.log(data + ", " + status)
                    });
            },
            uploadImage: function(image, name){
                console.log("Uploading" + name)
                var fd = new FormData();
                //Take the first selected file
                fd.append("file", image);
                fd.append("name", name);

                $http.post(serverUrl+'image/upload', fd, {
                    headers: {'Content-Type': undefined },
                    transformRequest: angular.identity
                })
                .success(function(data, status, headers, config){
                    //$rootScope.$broadcast('imageUploaded', data);
                    console.log(data)
                })
                .error(function(data, status, headers, config){
                    $rootScope.$broadcast('error', data);
                });
            },
        }
    }
]);

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

webcomicat.service('userService', ['$rootScope', '$http',
    function($rootScope, $http){
        return {
            listUsers: function(){
                $http.get(serverUrl+'manageComic/getAllUsers')
                    .success(function(data, status, headers, config){
                        $rootScope.$broadcast('gotUsers', data);
                    })
                    .error(function(data, status, headers, config){
                        console.log(status)
                    });
            },
            saveUser: function(user){
                $http.post(serverUrl+'manageComic/saveUser', user)
                    .success(function(data, status, headers, config){
                        $rootScope.$broadcast('userSaved', data);
                    })
                    .error(function(data, status, headers, config){
                        console.log(status)
                    });
            },
            deleteUser: function(user){
                $http.post(serverUrl+'manageComic/deleteUser', user)
                    .success(function(data, status, headers, config){
                        $rootScope.$broadcast('userDeleted');
                    })
                    .error(function(data, status, headers, config){
                        console.log(status)
                    });
            },
        }
    }
]);

webcomicat.controller("AdminController", ['$scope', 'comicPageService',
                                          'chapterService', 'generalService',
                                          'userService',
    function($scope, comicPageService, chapterService, generalService, userService){
        comicPageService.listComicPages();
        chapterService.listChapters();
        generalService.getSettings();
        userService.listUsers();

        $scope.listOrderBy='releaseDate'
        $scope.listOrder=true

        $scope.editingUser=null

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
        $scope.settingImages = {
            favicon:null,
            profilePicture:null
        }

        /* Functions */
        $scope.saveSettings = function(){
            var settings = jQuery.extend(true, {}, $scope.settings);
            settings.aboutAuthor = $scope.settings.aboutAuthor.split("\n")
            settings.aboutComic = $scope.settings.aboutComic.split("\n")
            generalService.saveSettings(settings, $scope.settingImages);
        }
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
        $scope.updateProfileImage = function(files){
            $scope.settingImages.profileImage = files[0]
        }
        $scope.updateFavicon = function(files){
            $scope.settingImages.favicon = files[0]
        }
        $scope.editUser = function(user){
            $scope.editingUser = user
        }
        $scope.newUser = function(user){
            $scope.editingUser = {
                username:"",
                password:"",
                isAdmin:false,
                isUser:false
            }
        }
        $scope.saveUser = function(user){
            userService.saveUser(user)
        }
        $scope.deleteUser = function(user){
            userService.deleteUser(user)
        }

        /* Listeners */
        $scope.$on('gotComicList', function(event, comicList){
            $scope.comics = comicList;
        })
        $scope.$on('gotChapters', function(event, chapters){
            $scope.chapters = chapters;
            if(chapters && chapters.length > 0)
                $scope.newComicPage.chapter = chapters[chapters.length - 1]
        })
        $scope.$on('gotSettings', function(event, settings){
            $scope.settings = settings;
            $scope.settings.aboutAuthor = settings.aboutAuthor.join("\n")
            $scope.settings.aboutComic = settings.aboutComic.join("\n")
        })
        $scope.$on('gotUsers', function(event, users){
            $scope.users = users;
        })
        $scope.$on('userSaved', function(event, users){
            $scope.feedbackMsg.text = "User saved successfully";
            $scope.feedbackMsg.type = "alert alert-success alert-dismissible";
            $scope.users = users;
        })
        $scope.$on('userDeleted', function(event, users){
            $scope.feedbackMsg.text = "User deleted successfully";
            $scope.feedbackMsg.type = "alert alert-success alert-dismissible";
            $scope.users = users;
        })
        $scope.$on('settingsSaved', function(event){
            $scope.feedbackMsg.text = "Settings saved successfully";
            $scope.feedbackMsg.type = "alert alert-success alert-dismissible";
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
