<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String auth_key = request.getParameter("auth_key");
	String no	= request.getParameter("no");
%>
<html class="no-js" lang="ko">
<head>

    <meta charset="utf-8">
    
    <!-- Bootstrap Core CSS -->
    <link href="../bower_components/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

	</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-lg-12 text-center">
            <h2>Edit Challenges</h2>
            <hr class="star-primary">
        </div>
    </div>
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <form action="../editProblem.jsp" method="post" id="writeForm" novalidate>
            	<input type="hidden" id="no" name="no" value=<%=no %>>
                <div class="row control-group">
                    <div class="form-group col-xs-12 floating-label-form-group controls">
                    	TITLE
                        <input type="text" class="form-control" mexlength="30" id="title" name="title" required data-validation-required-message="Enter the Title." value='<%=title%>'>
                        <p class="help-block text-danger"></p>
                    </div>
                </div>
                <div class="row control-group">
                    <div class="form-group col-xs-12 floating-label-form-group controls">
                        TYPE
                        <select multiple class="form-control" id="type" name="type">
        					<option selected value="system">system</option>
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
                        <!-- <input type="textarea" class="form-control" maxlength="100" row="5" cols="50" placeholder="내용을 입력해주세요." id="content" name="content" required data-validation-required-message="Please Enter the contents"> -->
                        <textarea class="form-control" maxlength="100" rows="5" placeholder="내용을 입력해주세요." id="content" name="content" required data-validation-required-message="Please Enter the contents" ><%=content%></textarea>
                        <p class="help-block text-danger"></p>
                        <!--FILE
                        <input type="file" class="form-control" id="file" name="file"> -->
                    </div>
                </div>
                <div class="row control-group">
                    <div class="form-group col-xs-12 floating-label-form-group controls">
                        SCORE
                      	<select multiple class="form-control" id="score" name="score">
        					<option selected value="100">100</option>
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
                        <input type="text" class="form-control" mexlength="15" id="key" name="key" required data-validation-required-message="Please Enter the Key" value='<%=auth_key %>'>
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
</body>
</html>