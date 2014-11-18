<html>
    <head>
        <meta name="layout" content="main">
        <asset:stylesheet href="webcomicat.css"/>
        <asset:javascript src="webcomicat.js"/>
        <asset:javascript src="libs/bootstrap/bootstrap.min.js"/>
    </head>

    <body>
        <div ng-app="webcomicat" ng-controller="ComicController">
            <div class="main-container">
                <div><button ng-click="page = page-1"><</button> {{page}} <button ng-click="page = page + 1">></button></div>
                <div ng-repeat="comic in comics | filter:{sequence: page}">
                    <div class="img-containter text-center">
                        <img ng-src="/comicPage/image?sequence={{comic.sequence}}&chapter={{comic.chapter.sequence}}">
                    </div>
                    <div>
                        <h2>{{comic.title}}</h2>
                        <div class="description">{{comic.description}}</div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
