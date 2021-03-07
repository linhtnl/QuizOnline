<%-- 
    Document   : dashboard
    Created on : Mar 4, 2021, 11:17:35 PM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Teacher Dashboard</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="../css/onepage.css"/>
    </head>
    <body>
        <%@include file="_header.jsp" %>
    <main>
        <div class="container">
            <form action="../QuestionController" method="POST" name="createQuestion">
                <div class="row">
                    <div class="col-md-3">
                        <select name="subject" id="subject">
                            <option value="">Choose a Subject</option>
                            <c:forEach items="${sessionScope.listSubject}" var="sub">
                                <option value="${sub.id}">${sub.id} - ${sub.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-9">
                        <select name="correctAnswer" id="correctAnswer">
                            <option value="">Correct Answer</option>
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="C">C</option>
                            <option value="D">D</option>
                        </select>
                    </div>
                </div><br>

                <div class="form-group">
                    <label for="questionContent">Question Contain </label> <span style="font-style: italic;font-size: 17px;color: red" id="questionContent_ERR"></span> <br>
                    <textarea id="questionContent" name="questionContent" rows="3" cols="80" >
                    </textarea>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <label>OptionA</label> 
                            <span style="font-style: italic;font-size: 17px;color: red" id="optionA_ERR"></span>
                            <br>
                            <textarea id="optionA" name="optionA" rows="2" cols="50" >
                            </textarea>
                        </div>

                    </div>
                    <div class="col">
                        <div class="form-group">
                            <label>OptionB</label>
                            <span style="font-style: italic;font-size: 17px;color: red" id="optionB_ERR"></span>
                            <br>
                            <textarea id="optionB" name="optionB" rows="2" cols="50" >
                            </textarea>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <label>OptionC</label>
                            <span style="font-style: italic;font-size: 17px;color: red" id="optionC_ERR"></span>
                            <br>
                            <textarea id="optionC" name="optionC" rows="2" cols="50" >
                            </textarea>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <label>OptionD</label>
                            <span style="font-style: italic;font-size: 17px;color: red" id="optionD_ERR"></span>
                            <br>
                            <textarea id="optionD" name="optionD" rows="2" cols="50" >
                            </textarea>
                        </div>
                    </div>
                </div>
                <span style="font-style: italic;font-weight: bold;font-size: 20px;color: red" id="create_ERR"></span>
                <br><br>

                <a href="dashboard.jsp" class="btn btn-secondary" >Back to dashboard</a>
                <button type="button" class="btn btn-primary" onclick="validate()">Create</button>
                <input type="hidden" value="create" name="action" />
            </form>
        </div>
    </main>
    <%@include file="_footer.jsp" %>
</body>
<script>
    function pageNum(num) {
        document.getElementById('pageNum').value = num;
        document.forms['pagination'].submit();
    }
    function clear() {
        document.getElementById('questionContent_ERR').innerHTML = '';
        document.getElementById('optionA_ERR').innerHTML = '';
        document.getElementById('optionB_ERR').innerHTML = '';
        document.getElementById('optionC_ERR').innerHTML = '';
        document.getElementById('optionD_ERR').innerHTML = '';
        document.getElementById('create_ERR').innerHTML = '';
    }
    function validate() {
        clear();
        var questionContent = document.getElementById('questionContent').value.trim();
        var optionA = document.getElementById('optionA').value.trim();
        var optionB = document.getElementById('optionB').value.trim();
        var optionC = document.getElementById('optionC').value.trim();
        var optionD = document.getElementById('optionD').value.trim();

        var flag = 0;
        //Check content not empty
        if (questionContent.length == 0) {
            document.getElementById('questionContent_ERR').innerHTML = '*Cannot empty';
            flag = 1;
        }
        //check optionA not empty
        if (optionA.length == 0) {
            document.getElementById('optionA_ERR').innerHTML = '*Cannot empty';
            flag = 1;
        }
        //check optionB not empty and different from A
        if (optionB.length == 0) {
            document.getElementById('optionB_ERR').innerHTML = '*Cannot empty';
            flag = 1;
        }
        else if (optionB == optionA) {
            document.getElementById('optionB_ERR').innerHTML = '*Must different from optionA';
            flag = 1;
        }
        //check optionC not empty and different from A,B
        if (optionC.length == 0) {
            document.getElementById('optionC_ERR').innerHTML = '*Cannot empty';
            flag = 1;
        }
        else if (optionC == optionA) {
            document.getElementById('optionC_ERR').innerHTML = '*Must different from optionA';
            flag = 1;
        }
        else if (optionC == optionB) {
            document.getElementById('optionC_ERR').innerHTML = '*Must different from optionB';
            flag = 1;
        }
        //check optionD not empty and different from A,B,C
        if (optionD.length == 0) {
            document.getElementById('optionD_ERR').innerHTML = '*Cannot empty';
            flag = 1;
        }
        else if (optionD == optionA) {
            document.getElementById('optionD_ERR').innerHTML = '*Must different from optionA';
            flag = 1;
        }
        else if (optionD == optionB) {
            document.getElementById('optionD_ERR').innerHTML = '*Must different from optionB';
            flag = 1;
        }
        else if (optionD == optionC) {
            console.log('eka');
            document.getElementById('optionD_ERR').innerHTML = '*Must different from optionC';
            flag = 1;
        }
        //Check subject and correct_answer
        var subID = document.getElementById('subject').value;
        var correctAnswer = document.getElementById('correctAnswer').value;
        if (subID == '') {
            document.getElementById('create_ERR').innerHTML = '*Please choose a subject';
            flag = 1;
        }
        if (correctAnswer == '') {
            document.getElementById('create_ERR').innerHTML = '*Please choose correct answer';
            flag = 1;
        }
        if (flag == 0) {
            document.forms['createQuestion'].submit();
        }
    }
</script>
</html>
