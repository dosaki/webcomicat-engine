<html>
    <head>
        <meta name="layout" content="main">
        <asset:javascript src="webcomicat.js"/>
        <asset:javascript src="libs/bootstrap/bootstrap.min.js"/>
    </head>

    <body>
        <div class="row">
            <div class="col-md-8">
                <div class="well">
                    <h2>About "${settings.comicTitle}"</h2>
                    <g:each var="paragraph" in="${settings.aboutComic}">
                        <p>${paragraph}</p>
                    </g:each>
                </div>
            </div>
            <div class="col-md-4">
                <div class="well">
                    <div class="text-center">
                        <img class="profile-pic" src="/image/get/profileImage"/>
                    </div>
                    <hr/>
                    <div>
                        <h3>About ${settings.mainAuthor}</h3>
                        <h4>${settings.mainAuthorEmail}</h4>
                        <g:each var="paragraph" in="${settings.aboutAuthor}">
                            <p>${paragraph}</p>
                        </g:each>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
