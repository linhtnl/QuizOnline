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
        <title>Student Dashboard</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="../css/onepage.css"/>
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
                    <div class="form">
                        <div class="container mt-3">
                            <h2>Take Quiz</h2>

                            <input class="form-control" id="myInput" type="text" placeholder="Search..">
                            <br>
                            <form action="../QuizEnrollController" method="POST" name="dashboard">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Quiz Code</th>
                                            <th>Subject</th>
                                            <th>Time Open</th>
                                            <th>Time Close</th>
                                            <th>Time Limit</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <c:forEach items="${sessionScope.listQuiz}" var="dto">
                                        <tbody id="myTable">     
                                            <tr>
                                                <td>${dto.quizID}</td>
                                                <td>${dto.subID} - ${dto.subName}</td>
                                                <td>${dto.timeOpen}</td>
                                                <td>${dto.timeClose}</td>
                                                <td>${dto.timeLimit} minutes</td>
                                                <td><button class="btn btn-primary" type="button" onclick="TakeQuiz('${dto.quizID}', '${dto.isReady}')"> Take Quiz</button></td>
                                            </tr>
                                        </tbody>
                                    </c:forEach>
                                </table>
                                <input type="hidden" name="action" value="take_quiz"/>
                                <input type="hidden" id="quizID" name="quizID" value=""/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>  
        </div>

        <%@include file="_footer.jsp" %>
    </body>
    <script>
        function TakeQuiz(quizID, isReady) {
            if (isReady == "false") {
                alert("Sorry, cannot take this quiz in this time!");
                return;
            } else {
                document.getElementById('quizID').value = quizID;
                document.forms['dashboard'].submit();
            }
        }
        $(document).ready(function() {
            $("#myInput").on("keyup", function() {
                var value = $(this).val().toLowerCase();
                $("#myTable tr").filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });
    </script>
</html>
