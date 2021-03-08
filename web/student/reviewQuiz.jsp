<%-- 
    Document   : quizzes
    Created on : Mar 7, 2021, 10:01:31 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz Detail</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="../css/onepage.css"/>
        <script>
            var page = 1;
            $(document).ready(function() {
                var arr = document.getElementsByClassName('questionID');
                for (var i = 0; i < arr.length; i++)
                    ids[i] = arr[i].id;
                hidden();
                for (var i = (5 - 5) * page; i < page * 5; i++) {
                    document.getElementById(ids[i]).style.display = "inline";
                }
                checkQuestion();
            });
            function checkQuestion() {
                for (var i = 0; i < ids.length; i++) {
                    var correct = document.getElementById('correct-' + ids[i]).value;
                    var stu = document.getElementById('stu-' + ids[i]).value;
                    var optionA = document.getElementById('optionA-' + ids[i]).value;
                    var optionB = document.getElementById('optionB-' + ids[i]).value;
                    var optionC = document.getElementById('optionC-' + ids[i]).value;
                    var optionD = document.getElementById('optionD-' + ids[i]).value;
                    console.log(i + stu + ' - ' + optionA);
                    flag = '';

                    switch (correct) {
                        case optionA:
                            document.getElementById('span-optionA' + flag + '-' + ids[i]).innerHTML = '  <img src="../img/951a617272553f49e75548e212ed947f-curved-check-mark-icon-by-vexels.png" width="25px" height="25px">';
                            break;
                        case optionB:
                            document.getElementById('span-optionB' + flag + '-' + ids[i]).innerHTML = '  <img src="../img/951a617272553f49e75548e212ed947f-curved-check-mark-icon-by-vexels.png" width="25px" height="25px">';
                            break;
                        case optionC:
                            document.getElementById('span-optionC' + flag + '-' + ids[i]).innerHTML = '  <img src="../img/951a617272553f49e75548e212ed947f-curved-check-mark-icon-by-vexels.png" width="25px" height="25px">';
                            break;
                        case optionD:
                            document.getElementById('span-optionD' + flag + '-' + ids[i]).innerHTML = '  <img src="../img/951a617272553f49e75548e212ed947f-curved-check-mark-icon-by-vexels.png" width="25px" height="25px">';
                            break;
                    }
                    if (stu != '') {
                        if (stu == optionA) {
                            document.getElementById('optionA-' + ids[i]).checked = true;
                            flag = 'A';
                        } else if (stu == optionB) {
                            document.getElementById('optionB-' + ids[i]).checked = true;
                            flag = 'B';
                        } else if (stu == optionC) {
                            document.getElementById('optionC-' + ids[i]).checked = true;
                            flag = 'C';
                        } else if (stu == optionD) {
                            document.getElementById('optionD-' + ids[i]).checked = true;
                            flag = 'D';
                        }
                    }
                    if (flag != '') {
                        var temp = 'option' + flag;
                        if (stu != correct) {
                            document.getElementById('span-option' + flag + '-' + ids[i]).innerHTML = '<img src="../img/5606866-mitchell-aluminium-american-red-cross-symbol-clip-art-wrong-png-cross-sign-png-709_612_preview.png" width="20px" height="20px">';
                        }
                    }
                }
            }
        </script>
    </head>

    <body>
        <%@include file="_header.jsp" %>    
        <div class="student-dashboard">
            <div class="nav-bar">
                <ul>
                    <li style="color:grey"><b>DASHBOARD</b></li><hr>
                    <li><a href="dashboard.jsp">Take Quiz</a></li>
                    <li><a href="quizzes.jsp">Review Quizzes</a></li>
                </ul>
            </div>
            <div class="student-main">
                <div class="container"> 
                    <h3>Review Quiz ${sessionScope.QuizEnrollDTO.quizID}</h3>
                    <h5>Score : ${sessionScope.QuizEnrollDTO.score}</h5>
                    <h5>Subject : ${sessionScope.QuizEnrollDTO.subID} - ${sessionScope.QuizEnrollDTO.subName}</h5>
                    <h5>Correct : ${sessionScope.QuizEnrollDTO.numOfCorrection}/${sessionScope.QuizEnrollDTO.numOfQuestion}</h5>
                    <h5>Time Enroll: ${sessionScope.QuizEnrollDTO.timeEnroll} </h5>
                </div><hr>
                <div class="container">

                    <c:forEach items="${sessionScope.questionsQuizz}" var="dto" varStatus="counter" >
                        <div id="${dto.questionID}" >
                            <input type="hidden"  id="correct-${dto.questionID}" value="${dto.correctAnswer}"/>
                            <input type="hidden" id="stu-${dto.questionID}" value="${dto.stuAnswer}"/>
                            <div id="${dto.questionID}" class="questionID">${counter.count}.${dto.content}</div>
                            <input type="radio"  id="optionA-${dto.questionID}" value="${dto.optionA}" disabled="true"/>
                            <label for="optionA" id="option-${dto.questionID}">${dto.optionA}</label><span id="span-optionA-${dto.questionID}"></span><br>
                            <input type="radio"  id="optionB-${dto.questionID}" value="${dto.optionB}" disabled="true"/>
                            <label for="optionB" id="option-${dto.questionID}">${dto.optionB}</label><span id="span-optionB-${dto.questionID}"></span><br>  
                                <input type="radio"  id="optionC-${dto.questionID}" value="${dto.optionC}" disabled="true"/>
                                <label for="optionC" id="option-${dto.questionID}">${dto.optionC}</label><span id="span-optionC-${dto.questionID}"></span><br>
                                    <input type="radio"  id="optionD-${dto.questionID}" value="${dto.optionD}" disabled="true"/>
                                    <label for="optionD" id="option-${dto.questionID}">${dto.optionD}</label><span id="span-optionD-${dto.questionID}"></span><br>
                                        <br>
                                        </div>
                                    </c:forEach>
                                    <div class="container">
                                        <button class="btn btn-dark" onclick="Previous()">
                                            <<
                                        </button >
                                        <button class="btn btn-dark" onclick="Next()">>></button>
                                    </div>
                                    </div>
                                    </div>  

                                    </div>
                                    <%@include file="_footer.jsp" %>
                                    </body>
                                    <script>
                                        function hidden() {
                                            for (var i = 0; i < ids.length; i++) {
                                                document.getElementById(ids[i]).style.display = "none";
                                            }
                                        }
                                        var ids = [];
                                        function Review(id) {
                                            document.getElementById('ID').value = id;
                                            document.forms['quizzes'].submit();
                                        }
                                        function Previous() {
                                            if (page == 1)
                                                return;
                                            page -= 1;
                                            hidden();
                                            display();
                                        }
                                        function Next() {
                                            if (page == parseInt(ids.length / 5))
                                                return;
                                            page += 1;
                                            hidden();
                                            display();
                                        }
                                        function display() {
                                            for (var i = 5 * (page - 1); i < page * 5; i++) {
                                                document.getElementById(ids[i]).style.display = "inline";
                                            }
                                        }
                                    </script>
                                    </html>
