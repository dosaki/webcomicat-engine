<html>
    <head>
        <meta name="layout" content="main">
        <asset:stylesheet href="webcomicat.css"/>
        <asset:javascript src="webcomicat.js"/>
        <asset:javascript src="libs/bootstrap/bootstrap.min.js"/>
    </head>

    <body>
        <div ng-app="webcomicat" ng-controller="AdminController">
            <div class="side-container">
                <ul class="nav nav-pills nav-stacked" role="tablist">
                    <li role="presentation" class="active"><a ng-click="listComics()">Comic Pages</a></li>
                </ul>
            </div>
            <div class="main-container">
                <div id="errorMessages" class="{{feedbackMsg.type}}">
                    <button type="button" class="close" data-dismiss="alert">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                    {{feedbackMsg.text}}
                </div>

                <div id="comicList" class="content">
                    <table class="table">
                        <thead>
                            <th>Thumbnail</th>
                            <th>Author</th>
                            <th>Title</th>
                            <th>Chapter</th>
                            <th>Release Date</th>
                            <th></th>
                        </thead>
                        <tbody>
                            <tr ng-repeat="comic in comics">
                                <td><img class="small-image-thumbnail" ng-src="manageComic/image?sequence={{comic.sequence}}&chapter={{comic.chapter.sequence}}"></td>
                                <td>{{comic.author}}</td>
                                <td>{{comic.title}}</td>
                                <td>{{comic.chapter.sequence}}: {{comic.chapter.title}}</td>
                                <td>{{comic.releaseDate}}</td>
                                <td><button class="btn btn-danger" ng-click="deleteComicPage(comic.id)">&times;</button></td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- Button for new page modal -->
                    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#newPageModal">
                        New Page
                    </button>

                    <!-- Button for new chapter modal -->
                    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#newChapter">
                        New Chapter
                    </button>

                    <!-- Page Modal -->
                    <div class="modal fade" id="newPageModal" tabindex="-1" role="dialog" aria-labelledby="newPageTitle" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">
                                        <span aria-hidden="true">&times;</span>
                                        <span class="sr-only">Close</span>
                                    </button>
                                    <h4 class="modal-title" id="newPageTitle">
                                        New Comic Page
                                    </h4>
                                </div>
                                <form ng-submit="createNewComicPage()">
                                    <div class="modal-body">
                                            <div class="input-group">
                                                <span class="input-group-addon form-label">Title</span>
                                                <input type="text" name="title" ng-model="newComicPage.title" class="form-control form-item" placeholder="Title for this particular page">
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon form-label">Chapter</span>
                                                <div class="dropdown form-item">
                                                    <button class="btn btn-default dropdown-toggle form-item" type="button" id="dropdownMenu1" data-toggle="dropdown">
                                                        <span ng-if="newComicPage.chapter == null">
                                                            Select Chapter
                                                        </span>
                                                        <span ng-if="newComicPage.chapter != null">
                                                            {{newComicPage.chapter.sequence}}: {{newComicPage.chapter.title}}
                                                        </span>
                                                        <span class="caret"></span>
                                                    </button>
                                                    <ul class="dropdown-menu form-item" role="menu" aria-labelledby="dropdownMenu1">
                                                        <li ng-repeat="chapter in chapters | orderBy:'sequence':true">
                                                            <a role="menuitem" tabindex="-1" href="#" ng-click="updateNewComicChapt(chapter)">{{chapter.sequence}}: {{chapter.title}}</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon form-label">Description</span>
                                                <input type="text" name="description" ng-model="newComicPage.description" class="form-control form-item"
                                                    placeholder="Anything you'd like to comment or say along with this page"/>
                                            </div>
                                            <div class="input-group text-center">
                                                <input id="imageInput" type="file" onchange="updatePreview(this.files);angular.element(this).scope().updateNewComicImg(this.files);" name="comicImage"/>
                                                <img id="comicPreview" class="image-thumbnail">
                                                <script>
                                                    function updatePreview(files){
                                                        if (files && files[0]) {
                                                            var reader = new FileReader();
                                                            reader.onload = function (e) {
                                                                $('#comicPreview').attr('src', e.target.result);
                                                            }
                                                            reader.readAsDataURL(files[0]);
                                                        }
                                                    }
                                                </script>
                                            </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">
                                            Close
                                        </button>
                                        <input type="submit" value="Upload New Comic" onclick="$('#newPageModal').modal('hide')" class="btn btn-primary"/>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>


                    <!-- Chapter Modal -->
                    <div class="modal fade" id="newChapter" tabindex="-1" role="dialog" aria-labelledby="newChapterTitle" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">
                                        <span aria-hidden="true">&times;</span>
                                        <span class="sr-only">Close</span>
                                    </button>
                                    <h4 class="modal-title" id="newChapterTitle">
                                        New Chapter
                                    </h4>
                                </div>
                                <form>
                                    <div class="modal-body">
                                            <div class="input-group">
                                                <span class="input-group-addon form-label">Title</span>
                                                <input type="text" name="title" class="form-control form-item" ng-model="newChapter.title" placeholder="Title for this chapter">
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon form-label">Sequence</span>
                                                <input type="text" name="chaptSequence" class="form-control form-item" ng-model="newChapter.sequence" placeholder="For ordering chapters">
                                            </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">
                                            Close
                                        </button>
                                        <button type="button" class="btn btn-primary" ng-click="createNewChapter(newChapter)" data-dismiss="modal">
                                            Create Chapter
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </body>
</html>
