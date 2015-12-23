<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

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
<body>
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2>Write New Challenges</h2>
                    <hr class="star-primary">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <form action="../addProblem.jsp" method="post" id="writeForm" novalidate>
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