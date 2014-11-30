<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<%@ page import="net.dosaki.webcomicat.Settings" %>

<%
	def settings = Settings.get(1)
%>
	<head>
		<title>${settings.comicTitle}</title>
		<g:layoutHead/>
	</head>
	<body>
		<div class="container">
			<div class="wrapper">
				<div class="header">
					<div class="page-header">
						<nav class="navbar navbar-default" role="navigation">
							<div class="container-fluid">
							<!-- Brand and toggle get grouped for better mobile display -->
								<div class="navbar-header">
									<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar">
										<span class="sr-only">Toggle navigation</span>
										<span class="icon-bar"></span>
										<span class="icon-bar"></span>
										<span class="icon-bar"></span>
									</button>
									<a class="navbar-brand" href="/"><img class="profile-pic" src="/assets/favicon.png"/></a>
								</div>

								<!-- Collect the nav links, forms, and other content for toggling -->
								<div class="collapse navbar-collapse" id="navbar">
									<ul class="nav navbar-nav">
										<li class="${current == 'home' ? 'active' : ''}"><a href="/">
											Webcomic <g:if test="${current == 'home'}"><span class="sr-only">(current)</span></g:if>
										</a></li>
										<li class="${current == 'about' ? 'active' : ''}"><a href="/general/about">
											About <g:if test="${current == 'about' }"><span class="sr-only">(current)</span></g:if>
										</a></li>
									</ul>
									<ul class="nav navbar-nav navbar-right">
        								<li><a>by ${settings.mainAuthor}</a></li>
									</ul>
								</div><!-- /.navbar-collapse -->
							</div><!-- /.container-fluid -->
						</nav>
					</div>
				</div>

				<div class="body">
					<g:layoutBody/>
				</div>
			</div>

			<div class="footer">
				<hr/>
				<p><small>Powered by <a href="https://github.com/dosaki/webcomicat-engine">webcomicat-engine</a>
				by <a href="https://github.com/dosaki">Tiago 'Dosaki' Correia</a></small><p>
			</div>
		</div>
	</body>
</html>
