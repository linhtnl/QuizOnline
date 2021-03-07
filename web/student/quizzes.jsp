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
        <title>Review Quizzes</title>
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
                            <h2>Quizzes are taken by you</h2>

                            <input class="form-control" id="myInput" type="text" placeholder="Search..">
                            <br>
                            <form action="../QuizEnrollController" method="POST" name="quizzes">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Quiz Code</th>
                                            <th>Subject</th>
                                            <th>Score</th>
                                            <th>Correct Answer</th>   
                                            <th>Time Enroll</th>   
                                            <th>
                                                Details
                                            </th>
                                        </tr>
                                    </thead>
                                    <c:forEach items="${sessionScope.listQuizTaken}" var="dto">
                                        <tbody id="myTable">     
                                            <tr>
                                                <td>${dto.quizID}</td>
                                                <td>${dto.subID} - ${dto.subName}</td>
                                                <td>${dto.score}</td>
                                                <td>${dto.numOfCorrection}/${dto.numOfQuestion}</td>
                                                <td>${dto.timeEnroll}</td>
                                                <td><button class="btn btn-primary" type="button" onclick="Review('${dto.ID}')">Review</button> </td>
                                            </tr>
                                        </tbody>
                                    </c:forEach>
                                </table>
                                <input type="hidden" name="action" value="review"/>
                                <input type="hidden" id="ID" name="ID" value=""/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>  
        </div>
        <%@include file="_footer.jsp" %>
    </body>
    <script>
        function Review(id){
            document.getElementById('ID').value=id;
            document.forms['quizzes'].submit();
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
