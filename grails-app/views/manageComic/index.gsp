<html>
    <head>
        <meta name="layout" content="main">
        <asset:javascript src="webcomicat_mgmt.js"/>
        <asset:javascript src="libs/bootstrap/bootstrap.min.js"/>
    </head>

    <body>
        <div ng-app="webcomicat" ng-controller="AdminController">
            <div class="side-container">
                <ul class="nav nav-pills nav-stacked" role="tablist">
                    <li role="presentation" class="active"><a href="#">Comic Pages</a></li>
                    <li role="presentation"><a href="/manageComic/settings">Settings</a></li>
                    <li role="presentation"><a href="/manageComic/users">User Management</a></li>
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
                            <th><a href="javascript:void(0)" ng-click="listOrderBy='author'; listOrder=!listOrder">
                                Author
                                <span ng-if="listOrderBy=='author'">
                                    <span ng-if="listOrder" class="glyphicon glyphicon-chevron-up"></span>
                                    <span ng-if="!listOrder" class="glyphicon glyphicon-chevron-down"></span>
                                </span>
                            </a></th>
                            <th><a href="javascript:void(0)" ng-click="listOrderBy='title'; listOrder=!listOrder">
                                Title
                                <span ng-if="listOrderBy=='title'">
                                    <span ng-if="listOrder" class="glyphicon glyphicon-chevron-up">
                                    </span><span ng-if="!listOrder" class="glyphicon glyphicon-chevron-down"></span>
                                </span>
                            </a></th>
                            <th><a href="javascript:void(0)" ng-click="listOrderBy='chapter'; listOrder=!listOrder">
                                Chapter
                                <span ng-if="listOrderBy=='chapter'">
                                    <span ng-if="listOrder" class="glyphicon glyphicon-chevron-up"></span>
                                    <span ng-if="!listOrder" class="glyphicon glyphicon-chevron-down"></span>
                                </span>
                            </a></th>
                            <th><a href="javascript:void(0)" ng-click="listOrderBy='releaseDate'; listOrder=!listOrder">
                                Release Date
                                <span ng-if="listOrderBy=='releaseDate'">
                                    <span ng-if="listOrder" class="glyphicon glyphicon-chevron-up"></span>
                                    <span ng-if="!listOrder" class="glyphicon glyphicon-chevron-down"></span>
                                </span>
                            </a></th>
                            <th></th>
                        </thead>
                        <tbody>
                            <tr ng-repeat="comic in comics | orderBy : listOrderBy : listOrder">
                                <td><img class="small-image-thumbnail" ng-src="manageComic/image?sequence={{comic.sequence}}&chapter={{comic.chapter.sequence}}"></td>
                                <td>{{comic.author}}</td>
                                <td>{{comic.title}}</td>
                                <td>{{comic.chapter.sequence}}: {{comic.chapter.title}}</td>
                                <td>{{comic.releaseDate}}</td>
                                <td>
                                    <button title="Delete" class="btn btn-danger" ng-click="deleteComicPage(comic.id)">
                                        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- Button for new page modal -->
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newPageModal">
                        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> New Page
                    </button>

                    <!-- Button for new chapter modal -->
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newChapter">
                        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> New Chapter
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
                                                <input type="text" name="title" ng-model="newComicPage.title" class="form-control form-item"
                                                        placeholder="Title for this particular page">
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon form-label">Chapter</span>
                                                <div class="dropdown form-item">
                                                    <button class="btn btn-default dropdown-toggle form-item" type="button"
                                                            id="dropdownMenu1" data-toggle="dropdown">
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
                                                            <a role="menuitem" tabindex="-1" href="#" ng-click="updateNewComicChapt(chapter)">
                                                                {{chapter.sequence}}: {{chapter.title}}
                                                            </a>
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
                                                <label id="outsideImageInputBtn" style="visibility: hidden;" for="imageInput" class="btn btn-primary">
                                                    <span class="glyphicon glyphicon-folder-open"></span> Choose Image
                                                </label>
                                                <input class="invisible" id="imageInput" type="file"
                                                    onchange="updatePreview(this.files);angular.element(this).scope().updateNewComicImg(this.files);"
                                                    name="comicImage"/>
                                                <div>
                                                    <div id="imgPlaceholder" class="image-thumbnail-placeholder">
                                                        <span class="icon-big glyphicon glyphicon-picture"></span><br/>
                                                        <label for="imageInput" class="btn btn-primary">
                                                            <span class="glyphicon glyphicon-folder-open"></span> Choose Image
                                                        </label>
                                                    </div>
                                                    <img id="comicPreview" class="image-thumbnail">
                                                    <script>
                                                        function updatePreview(files){
                                                            if (files && files[0]) {
                                                                $("#imgPlaceholder").hide();
                                                                $("#outsideImageInputBtn")[0].style.visibility="visible"
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
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-primary" onclick="$('#newPageModal').modal('hide')">
                                            <span class="glyphicon glyphicon-upload"></span> Upload Comic
                                        </button>
                                        <button type="button" class="btn btn-default" data-dismiss="modal">
                                            Close
                                        </button>
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
                                        <button type="button" class="btn btn-primary" ng-click="createNewChapter(newChapter)" data-dismiss="modal">
                                            Create Chapter
                                        </button>
                                        <button type="button" class="btn btn-default" data-dismiss="modal">
                                            Close
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
