<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String sessionId = (String)session.getAttribute("sessionId");
	String chk_admin = (String)session.getAttribute("chk_admin");

	boolean isLogin = false;
	boolean isAdmin = false;
	
	if( sessionId != null && !sessionId.equals("") ) {
		isLogin = true;
	}
	if( chk_admin != null && chk_admin.equals("T") ) {
		isAdmin = true;
	}
%>

<html class="no-js" lang="ko">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>2015 Kknock Survival Game</title>

    <!-- Bootstrap Core CSS - Uses Bootswatch Flatly Theme: http://bootswatch.com/flatly/ -->
    <link href="bower_components/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="dist/css/freelancer.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body id="page-top" class="index">
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// --><!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#page-top">SURVIVAL GAME</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
					<li class="page-scroll">
                        <a href="#notice">notice</a>
                    </li>
                    <%
                    	if(isLogin) out.println("<li class=\"page-scroll\"> <a href=\"#challenge\">challenge</a> </li> ");
                    %>
                    <li class="page-scroll">
                        <a href="#rank">rank</a>
                    </li>
                    <li class="page-scroll">
	                    <% 
	                    	if(isLogin) {
	                    		if(isAdmin) out.println("<a href=\"manager-page/index.jsp\">Manage</a>");
	                    		else 		out.println("");
	                    	}
	                    	else {
	                    		out.println("<a href=\"#contact\">Contact</a>");
	                    	}
	                    %>
                        
                    </li>
                    <li>
                    <% 
                    	if(isLogin){
                    		if(isAdmin) out.println("<a href=\"#write\">Write</a>");
                    		else out.println("<a href=\"#auth\">Auth</a>");
                    	}
                    %>
                    </li>
                    <li>
                    <% 
                    	if(isLogin) out.println("<a href=\"logout.jsp\">Logout</a>");                      	
                    	else		out.println("<a href=\"#login\" data-toggle=\"modal\">Login</a>");
                    %>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>

    <!-- Header -->
    <header>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <img src="dist/img/profile.png" alt="">
                    <div class="intro-text">
                        <span class="name">SURVIVAL GAME</span>
                        <hr class="star-light">
                        <span class="skills">2015 K.knock Survival Game</span>
                    </div>
                </div>
            </div>
        </div>
    </header>
	
	<!-- notice Section -->  
    <section id="notice">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2>notice</h2>
                    <hr class="star-light">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-lg-offset-2" style="overflow-x:hidden; overflow-y:scroll; width:70%; height:400px;" id="noticeBody">
                </div>
            </div>
        </div>
    </section>

     <!-- challenge Grid Section -->
    <section id="challenge" <%if(!isLogin){out.print("style=display:none");}%>>
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2>challenge</h2> 
                    <hr class="star-primary">
                </div>
            </div>
            <div class="row">
                <div class="col-sm-4 challenge-item">
                    <a href="#challengeModal" class="challenge-link" data-toggle="modal">
                        <div class="caption" probtype="system" sessionId=<%=(String)session.getAttribute("sessionId")%>>
                            <div class="caption-content">
                                <i class="fa fa-search-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="dist/img/challenge/system.png" class="img-responsive" alt="">
                    </a>
                </div>
                <div class="col-sm-4 challenge-item">
                    <a href="#challengeModal" class="challenge-link" data-toggle="modal">
                        <div class="caption" probtype="web">
                            <div class="caption-content">
                                <i class="fa fa-search-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="dist/img/challenge/web.png" class="img-responsive" alt="">
                    </a>
                </div>
                <div class="col-sm-4 challenge-item">
                    <a href="#challengeModal" class="challenge-link" data-toggle="modal">
                        <div class="caption" probtype="reversing">
                            <div class="caption-content">
                                <i class="fa fa-search-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="dist/img/challenge/reversing.png" class="img-responsive" alt="">
                    </a>
                </div>
                <div class="col-sm-4 challenge-item">
                    <a href="#challengeModal" class="challenge-link" data-toggle="modal">
                        <div class="caption" probtype="forensic">
                            <div class="caption-content">
                                <i class="fa fa-search-plus fa-3x"></i>
                            </div>
                        </div>
						<img src="dist/img/challenge/forensic.png" class="img-responsive" alt="">
                    </a>
                </div>
                <div class="col-sm-4 challenge-item">
                    <a href="#challengeModal" class="challenge-link" data-toggle="modal">
                        <div class="caption" probtype="network">
                            <div class="caption-content">
                                <i class="fa fa-search-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="dist/img/challenge/network.png" class="img-responsive" alt="">
                    </a>
                </div>
                <div class="col-sm-4 challenge-item">
                    <a href="#challengeModal" class="challenge-link" data-toggle="modal">
                        <div class="caption" probtype="etc">
                            <div class="caption-content">
                                <i class="fa fa-search-plus fa-3x"></i>
                            </div>
                        </div>
 						<img src="dist/img/challenge/etc.png" class="img-responsive" alt="">
                    </a>
                </div>
            </div>
        </div>
    </section>
    
  <!-- Write Section -->
    <section id="write" <%if(!isAdmin){out.print("style=display:none");}%>>
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2>Write New Challenges</h2>
                    <hr class="star-primary">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <form action="addProblem.jsp" method="post" id="writeForm" novalidate>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                            	TITLE
                                <input type="text" class="form-control" placeholder="제목을 입력해주세요." id="title" name="title" required data-validation-required-message="Enter the Title.">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                TYPE
                                <select multiple class="form-control" id="type" name="type">
                					<option value="system">system</option>
                    				<option value="web">web</option>
                    				<option value="reversing">reversing</option>
                    				<option value="network">network</option>
                    				<option value="forensic">forensic</option>
                    				<option value="etc">etc</option>
                				</select>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                CONTENTS
                                <input type="textarea" class="form-control" placeholder="내용을 입력해주세요." id="content" name="content" required data-validation-required-message="Please Enter the contents">
                                <p class="help-block text-danger"></p>
                                FILE
                                <input type="file" class="form-control" id="file" name="file">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                SCORE
                              	<select multiple class="form-control" id="score" name="score">
                					<option value="100">100</option>
                    				<option value="200">200</option>
                    				<option value="300">300</option>
                    				<option value="400">400</option>
                    				<option value="500">500</option>
                				</select>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                AUTH_KEY
                                <input type="text" class="form-control" placeholder="Key값을 입력해주세요!" id="key" name="key" required data-validation-required-message="Please Enter the Key">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <br>
                        <div id="success"></div>
                        <div class="row">
                            <div class="form-group col-xs-12">
                                <center><button type="submit" class="btn btn-success btn-lg">Add</button></center>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
    
	<!--rank section-->
	<section id="rank">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2>rank</h2>
                    <hr class="star-primary">
						<div class="col-lg-12">
							<div id="morris-bar-chart"></div>
						</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" <%if(isLogin){out.print("style=display:none");}%>>
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2>Contact Me</h2>
                    <hr class="star-primary">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <form action="contact_chk.jsp" method="post" id="contactForm" novalidate>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                            	ID
                                <input type="text" class="form-control" placeholder="15자 이내로 입력해주세요." id="id" name="id" required data-validation-required-message="Please enter your ID.">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                Name
                                <input type="text" class="form-control" placeholder="학번+이름      ex)12지혜선" id="name" name="name" required data-validation-required-message="Please enter your Name.">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                Password
                                <input type="password" class="form-control" placeholder="32자 이내로 입력해주세요." id="password" name="pw" required data-validation-required-message="Please enter your Password.">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                Check Password
                                <input type="password" class="form-control" placeholder="32자 이내로 입력해주세요." id="password" name="pw_chk" required data-validation-required-message="Please enter your Password.">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <br>
                        <div id="success"></div>
                        <div class="row">
                            <div class="form-group col-xs-12">
                                <center><button type="submit" class="btn btn-success btn-lg">Send</button></center>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

	 <!-- Authorization Section -->
    <section id="auth" <%if(!isLogin){out.print("style=display:none");}%>>
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2>Did you got a key?</h2>
                    <hr class="star-primary">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <form onsubmit="return handler_auth(key.value)" method="post" id="authForm" novalidate>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                            	KEY
                                <input type="text" class="form-control" placeholder="Do not bruteforce" id="key" name="key" required data-validation-required-message="Please enter valid key.">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        
                        <br>
                        <div id="success"></div>
                        <div class="row">
                            <div class="form-group col-xs-12">
                                <center><button type="submit" class="btn btn-success btn-lg">Auth</button></center>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="text-center">
        <div class="footer-above">
            <div class="container">
                <div class="row">
                    <div class="footer-col col-md-4">
                        <h3>Location</h3>
                        <p>3481 Melrose Place<br>Beverly Hills, CA 90210</p>
                    </div>
                    <div class="footer-col col-md-4">
                        <h3>Around the Web</h3>
                        <ul class="list-inline">
                            <li>
                                <a href="#" class="btn-social btn-outline"><i class="fa fa-fw fa-facebook"></i></a>
                            </li>
                            <li>
                                <a href="#" class="btn-social btn-outline"><i class="fa fa-fw fa-google-plus"></i></a>
                            </li>
                            <li>
                                <a href="#" class="btn-social btn-outline"><i class="fa fa-fw fa-twitter"></i></a>
                            </li>
                            <li>
                                <a href="#" class="btn-social btn-outline"><i class="fa fa-fw fa-linkedin"></i></a>
                            </li>
                            <li>
                                <a href="#" class="btn-social btn-outline"><i class="fa fa-fw fa-dribbble"></i></a>
                            </li>
                        </ul>
                    </div>
                    <div class="footer-col col-md-4">
                        <h3>notice Freelancer</h3>
                        <p>Freelance is a free to use, open source Bootstrap theme created by <a href="http://startbootstrap.com">Start Bootstrap</a>.</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-below">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        Copyright &copy; Your Website 2014
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
    <div class="scroll-top page-scroll visible-xs visible-sm">
        <a class="btn btn-primary" href="#page-top">
            <i class="fa fa-chevron-up"></i>
        </a>
    </div>

    <!-- challenge Modals -->
	<div class="challenge-modal modal fade" id="challengeModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
			<section id="challenge">
				<div class="container">
					<div class="row">
						<div class="col-lg-8 col-lg-offset-2">
							<div class="modal-body" id="challenge-list">
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
    

	<!--challenge page modals-->
    <div class="challenge-modal modal fade" id="challengePage" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container" >
            	 <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body" id="challengeBody">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!--Login modals-->
	<div class="login-modal modal fade" id="login" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                	<div class="modal-body">
                		<h2> Login </h2>
                		<hr class="star-primary">
                    <form action = "login_chk.jsp" method="post" id="loginForm" novalidate>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label>ID</label>
                                <input type="text" class="form-control" placeholder="id" id="id" name="id" required data-validation-required-message="Please enter your ID.">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label>Password</label>
                                <input type="password" class="form-control" placeholder="password" id="password" name="pw" required data-validation-required-message="Please enter your Password.">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <br>
                        <div id="success"></div>
                        <div class="row">
                            <div class="form-group col-xs-12">
                                <button type="submit" class="btn btn-success btn-lg">Send</button>
                                <button type="button" class="btn btn-success btn-lg" data-dismiss="modal"><i class="fa fa-times"></i> Close</button>
                            </div>
                        </div>
                    </form>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="bower_components/jquery/dist/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="bower_components/bootstrap/js/bootstrap.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    <script src="dist/js/classie.js"></script>
    <script src="dist/js/cbpAnimatedHeader.js"></script>

    <!-- Contact Form JavaScript -->
    <script src="dist/js/jqBootstrapValidation.js"></script>
    <script src="dist/js/contact_me.js"></script>

	<script src="bower_components/raphael/raphael-min.js"></script>
	<script src="bower_components/morrisjs/morris.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="dist/js/freelancer.js"></script>
    <script src="dist/js/getprobList.js"></script>
    <script src="dist/js/getProblem.js"></script>
    <script src="dist/js/getNotice.js"></script>
    <script src="dist/js/handler.js"></script>

</body>

</html>
