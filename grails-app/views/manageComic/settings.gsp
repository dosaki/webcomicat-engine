<html>
    <head>
        <meta name="layout" content="main">
        <asset:stylesheet href="webcomicat.css"/>
        <asset:javascript src="webcomicat_mgmt.js"/>
        <asset:javascript src="libs/bootstrap/bootstrap.min.js"/>
    </head>

    <body>
        <div ng-app="webcomicat" ng-controller="AdminController">
            <div class="side-container">
                <ul class="nav nav-pills nav-stacked" role="tablist">
                    <li role="presentation"><a href="/manageComic">Comic Pages</a></li>
                    <li role="presentation" class="active"><a href="#">Settings</a></li>
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

                <div id="settings" class="content">
                    <div class="input-group">
                        <span class="input-group-addon form-label">Webcomic Title</span>
                        <input type="text" name="title" ng-model="settings.comicTitle" class="form-control form-item" placeholder="Title of your webcomic!">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon form-label">About {{settings.comicTitle.length <= 10 ? settings.comicTitle : "your comic"}}</span>
                        <textarea type="text" name="title" ng-model="settings.aboutComic" cols="40" rows="5" class="form-control form-item" placeholder="Some text explaining a bit about your webcomic..."></textarea>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon form-label">Author Name</span>
                        <input type="text" name="title" ng-model="settings.mainAuthor" class="form-control form-item" placeholder="Your name">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon form-label">Author Email</span>
                        <input type="text" name="title" ng-model="settings.mainAuthorEmail" class="form-control form-item" placeholder="Your email">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon form-label">About {{settings.mainAuthor.length <= 10 ? settings.mainAuthor : "you"}}</span>
                        <textarea type="text" name="title" ng-model="settings.aboutAuthor" cols="40" rows="5" class="form-control form-item" placeholder="Tell everyone a bit about you"></textarea>
                    </div>

                    <button type="button" class="btn btn-primary" data-toggle="modal" ng-click="saveSettings()">
                        <span class="glyphicon glyphicon-floppy-disk"></span> Save Changes
                    </button>

                </div>
            </div>
        </div>
    </body>
</html>
