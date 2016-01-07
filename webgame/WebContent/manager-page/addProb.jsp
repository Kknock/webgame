<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

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