<html>
    <head>
        <meta name="layout" content="main">
        <asset:stylesheet href="webcomicat.css"/>
        <asset:javascript src="webcomicat.js"/>
        <asset:javascript src="libs/bootstrap/bootstrap.min.js"/>
    </head>

    <body>
        <div class="row">
            <div class="col-md-8">
                <div class="well">
                    <h2>About "${settings.comicTitle}"</h2>
                    <div>
                        ${settings.aboutComic}
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="well">
                    <div class="text-center">
                        <img class="profile-pic" src="/assets/profile_pic.png"/>
                    </div>
                    <hr/>
                    <div>
                        <h3>About ${settings.mainAuthor}</h3>
                        <p>${settings.aboutAuthor}</p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
