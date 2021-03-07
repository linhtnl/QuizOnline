<%-- 
    Document   : takequiz
    Created on : Mar 7, 2021, 12:10:26 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz Attempt</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="../js/pagination.js"></script>

        <link rel="stylesheet" href="../css/onepage.css"/>

    </head>
    <body>
        <%@include file="_header.jsp" %> 
        <form action="../QuizEnrollController" method="POST" name="takequiz">
            <div class="student-dashboard">
                <div class="nav-bar" style="background: #f1f1f1">
                    <input type="hidden" id="timeLimit" value="${sessionScope.quizDTO.timeLimit-1}" />
                    <h1>Time left: </h1>
                    <h1 id="time-counter">${sessionScope.quizDTO.timeLimit-1} : 59</h1>
                    <hr>
                    <h6>Subject: ${sessionScope.quizDTO.subID} - ${sessionScope.quizDTO.subName}</h6> 
                    <h6>Quiz Code: ${sessionScope.quizDTO.quizID}</h6>
                    <h6>Total question: ${sessionScope.quizDTO.numOfQuestions}</h6>

                    <input value="Submit" name="action" class="btn btn-primary" type="submit" style="width: 120px;"/>
                </div>
                <div class="container">
                    <c:forEach items="${sessionScope.exam}" var="dto">
                        <div id="${dto.questionID}" style="display: none">
                            <div id="question-content-${dto.questionID}"></div>
                            <input type="radio"  name="option-${dto.questionID}" value="${dto.optionA}" >
                            <label for="optionA" id="optionA-${dto.questionID}"></label><br>
                            <input type="radio"  name="option-${dto.questionID}" value="${dto.optionB}">
                            <label for="optionB" id="optionB-${dto.questionID}"></label><br>  
                            <input type="radio"  name="option-${dto.questionID}" value="${dto.optionC}">
                            <label for="optionC" id="optionC-${dto.questionID}"></label><br>
                            <input type="radio"  name="option-${dto.questionID}" value="${dto.optionD}">
                            <label for="optionD" id="optionD-${dto.questionID}"></label><br>
                            <br>
                        </div>
                    </c:forEach>

                </div>

                <div class="paging">
                    <button type="button" onclick="previous()"><<</button>
                    <button type="button" onclick="next()">>></button>
                </div>
            </div>
        </form>
        <%@include file="_footer.jsp" %>
    </body>
    <script>
        var page = 0;
        var sources = '';
        $(document).ready(function() {
            $.getJSON("../QuizEnrollController", function(result) {
                sources = result;
                document.getElementById(sources[0].questionID).style.display = "inline";
                document.getElementById('question-content-' + result[0].questionID).innerHTML = page + 1 + ". " + result[0].content;
                document.getElementById('optionA-' + result[0].questionID).innerHTML = result[0].optionA;
                document.getElementById('optionB-' + result[0].questionID).innerHTML = result[0].optionB;
                document.getElementById('optionC-' + result[0].questionID).innerHTML = result[0].optionC;
                document.getElementById('optionD-' + result[0].questionID).innerHTML = result[0].optionD;
            });
        });
        function hidden() {
            for (var i = 0; i < sources.length; i++) {
                document.getElementById(sources[i].questionID).style.display = "none";
            }
        }
        function fillData() {
            hidden();
            document.getElementById('question-content-' + sources[page].questionID).innerHTML = page + 1 + ". " + sources[page].content;
            document.getElementById('optionA-' + sources[page].questionID).innerHTML = sources[page].optionA;
            document.getElementById('optionB-' + sources[page].questionID).innerHTML = sources[page].optionB;
            document.getElementById('optionC-' + sources[page].questionID).innerHTML = sources[page].optionC;
            document.getElementById('optionD-' + sources[page].questionID).innerHTML = sources[page].optionD;
            document.getElementById(sources[page].questionID).style.display = "inline";
        }
        function previous() {
            if (page == 0) {
                return;
            }
            else {
                page -= 1;
                fillData();
            }
        }
        function next() {
            if (page == sources.length - 1) {
                return;
            }
            else {
                page += 1;
                fillData();
            }
        }

        // Set the date we're counting down to
        var countDownMin = parseInt(document.getElementById('timeLimit').value);
        var countDownSec = 59;
        var t = 1;

        // Update the count down every 1 second
        var x = setInterval(function() {
            var distance = countDownSec - t;
            t += 1;
            var flag = 0;
            if (distance < 10) {
                document.getElementById("time-counter").innerHTML = countDownMin + " : 0" + distance;
            }
            else
                document.getElementById("time-counter").innerHTML = countDownMin + " : " + distance;
            if (t > 59) {


                countDownMin -= 1;
                t = 0;
                countDownSec = 59;

            }
            if (distance == 1 && countDownMin == 0) {
                flag = 1;
            }

            // If the count down is over, write some text 
            if (flag == 1) {
                clearInterval(x);
                document.getElementById("time-counter").innerHTML = "EXPIRED";
                document.forms['takequiz'].submit();
            }
        }, 1000);
    </script>
</script>
</html>
