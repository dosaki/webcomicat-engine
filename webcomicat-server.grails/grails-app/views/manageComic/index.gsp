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
                    <li role="presentation"> <a ng-click="listUsers()">Users</a></li>
                </ul>
            </div>
            <div class="main-container">
                <div id="comicList" class="content">
                    <table class="table">
                        <thead>
                            <th>Author</th>
                            <th>Title</th>
                            <th>Chapter</th>
                            <th>Release Date</th>
                        </thead>
                        <tbody>
                            <tr ng-repeat="comic in comics">
                                <td>{{comic.author.username}}</td>
                                <td>{{comic.title}}</td>
                                <td>{{comic.chapter}}</td>
                                <td>{{comic.releaseDate}}</td>
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
                                <g:uploadForm action="newComicPage">
                                    <div class="modal-body">
                                            <div class="input-group">
                                                <span class="input-group-addon form-label">Title</span>
                                                <input type="text" name="title" class="form-control form-item" placeholder="Title for this particular page">
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon form-label">Chapter</span>
                                                <div class="dropdown form-item">
                                                    <button class="btn btn-primary dropdown-toggle form-item" type="button" id="dropdownMenu1" data-toggle="dropdown">
                                                        -- select --
                                                        <span class="caret"></span>
                                                    </button>
                                                    <ul class="dropdown-menu form-item" role="menu" aria-labelledby="dropdownMenu1">
                                                        <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Action</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon form-label">Description</span>
                                                <input type="text" name="description" class="form-control form-item"
                                                    placeholder="Anything you'd like to comment or say along with this page"/>
                                            </div>
                                            <div class="input-group">
                                                  <input type="file" name="comicImage"/>
                                            </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">
                                            Close
                                        </button>
                                        <input type="submit" value="Upload New Comic" class="btn btn-primary"/>
                                    </div>
                                </g:uploadForm>
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
                                <g:uploadForm action="newChapter">
                                    <div class="modal-body">
                                            <div class="input-group">
                                                <span class="input-group-addon form-label">Title</span>
                                                <input type="text" name="title" class="form-control form-item" placeholder="Title for this chapter">
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon form-label">Sequence</span>
                                                <input type="text" name="chaptSequence" class="form-control form-item" placeholder="For ordering chapters">
                                            </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">
                                            Close
                                        </button>
                                        <input type="submit" value="Create Chapter" class="btn btn-primary"/>
                                    </div>
                                </g:uploadForm>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </body>
</html>
