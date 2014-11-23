<html>
    <head>
        <meta name="layout" content="main">
        <asset:stylesheet href="webcomicat.css"/>
        <asset:javascript src="webcomicat.js"/>
        <asset:javascript src="libs/bootstrap/bootstrap.min.js"/>
    </head>

    <body>
        <div ng-app="webcomicat" ng-controller="ComicController">
            <nav class="text-center">
                <ul class="pagination">
                    <li><a href="#" ng-click="page = 0">&#10096;&#10096;</a></li>
                    <li><a href="#" ng-click="page = incrementPage()">&#10096;</a></li>
                    <li><a href="#">{{page}}</a></li>
                    <li><a href="#" ng-click="page = decrementPage()">&#10097;</a></li>
                    <li><a href="#" ng-click="page = comics.length - 1">&#10097;&#10097;</a></li>
                </ul>
            </nav>
            <div ng-repeat="comic in comics | filter:{sequence: page}">
                <div class="img-containter">
                    <img style="max-width:100%;" ng-src="/comicPage/image?sequence={{comic.sequence}}&chapter={{comic.chapter.sequence}}">
                </div>
                <div>
                    <h2>{{comic.title}}</h2>
                    <div class="description">{{comic.description}}</div>
                </div>
            </div>
            <nav class="text-center">
                <ul class="pagination">
                    <li><a href="#" ng-click="page = 0">&#10096;&#10096;</a></li>
                    <li><a href="#" ng-click="page = page-1">&#10096;</a></li>
                    <li><a href="#">{{page}}</a></li>
                    <li><a href="#" ng-click="page = page + 1">&#10097;</a></li>
                    <li><a href="#" ng-click="page = comics.length - 1">&#10097;&#10097;</a></li>
                </ul>
            </nav>
        </div>
    </body>
</html>
