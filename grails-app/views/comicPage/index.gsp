<html>
    <head>
        <meta name="layout" content="main">
        <asset:javascript src="webcomicat.js"/>
        <asset:javascript src="libs/bootstrap/bootstrap.min.js"/>
    </head>

    <body>
        <div ng-app="webcomicat" ng-controller="ComicController">
            <nav class="text-center">
                <ul class="pagination">
                    <li><a href="javascript:void(0)" ng-click="page = 0">
                        <span class="glyphicon glyphicon-step-backward" aria-hidden="true"></span>
                    </a></li>
                    <li><a href="javascript:void(0)" ng-click="page = incrementPage()">
                        <span class="glyphicon glyphicon-backward" aria-hidden="true"></span>
                    </a></li>
                    <li><a>{{page+1}}</a></li>
                    <li><a href="javascript:void(0)" ng-click="page = decrementPage()">
                        <span class="glyphicon glyphicon-forward" aria-hidden="true"></span>
                    </a></li>
                    <li><a href="javascript:void(0)" ng-click="page = comics.length - 1">
                        <span class="glyphicon glyphicon-step-forward" aria-hidden="true"></span>
                    </a></li>
                </ul>
            </nav>
            <div ng-if="comics.length == 0">
                <div class="img-containter well text-center">
                    The author hasn't posted any comics!
                    For shame!
                </div>
            </div>
            <div ng-repeat="comic in comics | filter:{sequence: page}">
                <div class="img-containter well">
                    <h2>{{comic.title}}</h2>
                    <div class="text-center">
                        <img style="max-width:100%;" ng-src="/comicPage/image?sequence={{comic.sequence}}&chapter={{comic.chapter.sequence}}">
                    </div>
                    <hr/>
                    <div>
                        <div class="description">{{comic.description}}</div>
                    </div>
                </div>
            </div>
                <nav class="text-center">
                    <ul class="pagination">
                        <li><a href="javascript:void(0)" ng-click="page = 0">
                            <span class="glyphicon glyphicon-step-backward" aria-hidden="true"></span>
                        </a></li>
                        <li><a href="javascript:void(0)" ng-click="page = incrementPage()">
                            <span class="glyphicon glyphicon-backward" aria-hidden="true"></span>
                        </a></li>
                        <li><a>{{page+1}}</a></li>
                        <li><a href="javascript:void(0)" ng-click="page = decrementPage()">
                            <span class="glyphicon glyphicon-forward" aria-hidden="true"></span>
                        </a></li>
                        <li><a href="javascript:void(0)" ng-click="page = comics.length - 1">
                            <span class="glyphicon glyphicon-step-forward" aria-hidden="true"></span>
                        </a></li>
                    </ul>
                </nav>
        </div>
    </body>
</html>
