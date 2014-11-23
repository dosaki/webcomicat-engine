<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<title>${grailsApplication.config.webcomicat.config.title}</title>
		<g:layoutHead/>
	</head>
	<body>
		<div class="container">
			<div class="header">
				<div class="page-header">
					<div>
						<nav class="navbar navbar-default" role="navigation">
							<div class="container-fluid">
							<!-- Brand and toggle get grouped for better mobile display -->
								<div class="navbar-header">
									<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
										<span class="sr-only">Toggle navigation</span>
										<span class="icon-bar"></span>
										<span class="icon-bar"></span>
										<span class="icon-bar"></span>
									</button>
									<a class="navbar-brand" href="#">${grailsApplication.config.webcomicat.config.title}</a>
								</div>

								<!-- Collect the nav links, forms, and other content for toggling -->
								<div class="collapse navbar-collapse" id="navbar">
									<ul class="nav navbar-nav">
										<li class="${current ? 'active' : ''}"><a href="/">
											Webcomic <g:if test="${current}"><span class="sr-only">(current)</span></g:if>
										</a></li>
										<li class="${current ? 'active' : ''}"><a href="/general/about">
											About <g:if test="${current}"><span class="sr-only">(current)</span></g:if>
										</a></li>
									</ul>
								</div><!-- /.navbar-collapse -->
							</div><!-- /.container-fluid -->
						</nav>
					</div>
				</div>
			</div>

			<div class="body">
				<g:layoutBody/>
			</div>

			<div class="footer">
				<small>Powered by <a href="https://github.com/dosaki/webcomicat-engine">webcomicat</a> by <a href="https://github.com/dosaki">Tiago 'Dosaki' Correia</a></small>
			</div>
		</div>
	</body>
</html>
