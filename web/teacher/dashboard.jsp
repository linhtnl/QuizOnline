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

        <div class="container" ><br>

            <a class="btn btn-success create-button" href="createQuetion.jsp"><img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJDYXBhXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgNTEyIDUxMiIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNTEyIDUxMjsiIHhtbDpzcGFjZT0icHJlc2VydmUiPg0KPGc+DQoJPGc+DQoJCTxwYXRoIGQ9Ik0yNTYsMEMxMTQuODMzLDAsMCwxMTQuODMzLDAsMjU2czExNC44MzMsMjU2LDI1NiwyNTZzMjU2LTExNC44NTMsMjU2LTI1NlMzOTcuMTY3LDAsMjU2LDB6IE0yNTYsNDcyLjM0MQ0KCQkJYy0xMTkuMjc1LDAtMjE2LjM0MS05Ny4wNDYtMjE2LjM0MS0yMTYuMzQxUzEzNi43MjUsMzkuNjU5LDI1NiwzOS42NTlTNDcyLjM0MSwxMzYuNzA1LDQ3Mi4zNDEsMjU2UzM3NS4yOTUsNDcyLjM0MSwyNTYsNDcyLjM0MXoNCgkJCSIvPg0KCTwvZz4NCjwvZz4NCjxnPg0KCTxnPg0KCQk8cGF0aCBkPSJNMzU1LjE0OCwyMzQuMzg2SDI3NS44M3YtNzkuMzE4YzAtMTAuOTQ2LTguODY0LTE5LjgzLTE5LjgzLTE5Ljgzcy0xOS44Myw4Ljg4NC0xOS44MywxOS44M3Y3OS4zMThoLTc5LjMxOA0KCQkJYy0xMC45NjYsMC0xOS44Myw4Ljg4NC0xOS44MywxOS44M3M4Ljg2NCwxOS44MywxOS44MywxOS44M2g3OS4zMTh2NzkuMzE4YzAsMTAuOTQ2LDguODY0LDE5LjgzLDE5LjgzLDE5LjgzDQoJCQlzMTkuODMtOC44ODQsMTkuODMtMTkuODN2LTc5LjMxOGg3OS4zMThjMTAuOTY2LDAsMTkuODMtOC44ODQsMTkuODMtMTkuODNTMzY2LjExNCwyMzQuMzg2LDM1NS4xNDgsMjM0LjM4NnoiLz4NCgk8L2c+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8L3N2Zz4NCg==" width="20px" height="20px" style="margin-right: 5px"/>Create Question</a><br>
            <h2>Question Bank</h2>  
            <form action="../QuestionController" method="POST" name="dashboard">
                <table class="table table-hover">
                    <thead class="table-head">
                        <tr>
                            <th>No</th>
                            <th>Question Content</th>
                            <th>Subject</th>                    
                            <th>Status</th>
                            <th>Update</th>
                            <th>Delete</th>
                        </tr>
                    </thead>  
                    <tbody>
                        <c:forEach items="${sessionScope.listQuestion}" var="dto" varStatus="counter">
                            <tr>
                                <td class="table-body-number">${(sessionScope.pageNum - 1) * 20 + counter.count}</td>
                                <td class="table-body-content">
                                    <a class="btn btn-link" data-toggle="modal" href="#myQuestion${counter.count}" style="text-align: left;"> <p>${dto.content} </p>
                                    </a>
                                    <!-- The Modal -->
                                    <div class="modal" id="myQuestion${counter.count}">
                                        <div class="modal-dialog">
                                            <div class="modal-content">

                                                <!-- Modal Header -->
                                                <div class="modal-header">
                                                    <h4 class="modal-title">QuestionID : ${dto.questionID}</h4>
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                </div>

                                                <!-- Modal body -->
                                                <div class="modal-body">
                                                    <div class="container question-modal">
                                                        <div class="row">
                                                            <div class="col"style="text-align: right">
                                                                <label >Subject</label>
                                                            </div>
                                                            <div class="col" >
                                                                <label>Status</label>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col" style="text-align: right">
                                                                ${dto.subID}
                                                            </div>
                                                            <div class="col">
                                                                <c:if test="${dto.isAvailable == false}">
                                                                    <span class="badge badge-danger">Deleted</span>
                                                                </c:if>
                                                                <c:if test="${dto.isAvailable == true}">
                                                                    <span class="badge badge-success">Available</span>
                                                                </c:if>   
                                                            </div>
                                                        </div>
                                                        <hr>
                                                        <label>Content: </label> <p>${dto.content}<p> 
                                                            <label>Option A:</label><p>${dto.optionA}</p> 
                                                        <label>Option B:</label><p> ${dto.optionB}</p>
                                                        <label>Option C:</label><p>${dto.optionC}</p>
                                                        <label>Option D:</label><p>${dto.optionD}</p>
                                                        <label>Correct Answer: </label><p>${dto.correctAnswer}</p>
                                                    </div>
                                                </div>
                                                <!-- Modal footer -->
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <p> ${dto.subID} - 
                                        <c:forEach items="${sessionScope.listSubject}" var="sub">
                                            <c:if test="${sub.id == dto.subID}">
                                                ${sub.name}
                                            </c:if>
                                        </c:forEach><p>
                                </td>
                                <td>
                                    <c:if test="${dto.isAvailable == false}">
                                        <span class="badge badge-danger">Deleted</span>
                                    </c:if>
                                    <c:if test="${dto.isAvailable == true}">
                                        <span class="badge badge-success">Available</span>
                                    </c:if>    
                                </td>
                                <td><button class="btn btn-primary" type="button" onclick="Update('${dto.questionID}')">Update</button> </td>
                                <td>
                                    <c:if test="${dto.isAvailable == true}">
                                        <button class="btn btn-danger" type="button" onclick="Delete('${dto.questionID}')"> Delete</button>
                                    </c:if>
                                </td>

                            </tr>


                        </c:forEach>

                    </tbody>
                </table> 
                <input type="hidden" name="action"  value=""/>
                <input type="hidden" name="questionID"  value=""/>
            </form>
        </div>
        <!--Pagination-->
        <div class="container" >
            <form action="../QuestionController" method="POST" name="pagination">
                <ul class="pagination" >
                    <!--
                    - Nếu total page <=3 thì chỉ hiện ra đúng số trang total page 
                    --- ở selected page thì active
                    - Nếu total page lớn hơn 3
                    --- Xem selected number(SN) là mấy
                    ------Nếu SN <= 2 thì hiện từ 1-3
                    ------Nếu SN => total page -2 thì hiện từ total đén total page -2
                    ------Còn lại hiện từ SN-1 đén SN+1
                    -->
                    <c:choose>
                        <c:when test="${sessionScope.totalPage <=3 }">
                            <c:forEach begin="1" end="${sessionScope.totalPage}" var="i">
                                <li class="page-item" id="page${i}"><a class="page-link"  onclick="pageNum('${i}')">${i}</a></li>
                                </c:forEach>
                            </c:when>
                            <c:when test="${sessionScope.totalPage >3 }">
                                <c:choose>
                                    <c:when test="${sessionScope.pageNum<=2}">
                                        <c:forEach begin="1" end="3" var="i">
                                        <li class="page-item" id="page${i}"><a class="page-link"  onclick="pageNum('${i}')">${i}</a></li>
                                        </c:forEach>
                                    </c:when>
                                    <c:when test="${sessionScope.pageNum>=sessionScope.totalPage-1}">
                                        <c:forEach begin="${sessionScope.totalPage-2}" end="${sessionScope.totalPage}" var="i">
                                        <li class="page-item" id="page${i}" ><a class="page-link" onclick="pageNum('${i}')">${i}</a></li>
                                        </c:forEach>
                                    </c:when> 
                                    <c:when test="${sessionScope.pageNum>2 && sessionScope.pageNum<sessionScope.totalPage-1}">
                                        <c:forEach begin="${sessionScope.pageNum-1}" end="${sessionScope.pageNum+1}" var="i">
                                        <li class="page-item" id="page${i}"><a class="page-link"  onclick="pageNum('${i}')">${i}</a></li>
                                        </c:forEach>
                                    </c:when>
                                </c:choose>
                            </c:when>
                        </c:choose>
                </ul>
                <input type="hidden" name="pageNum" value="" id="pageNum"/>
                <input type="hidden" name="action" value="pagination"/>
            </form>            
        </div>
        <%@include file="_footer.jsp" %>
    </body>
    <script>
        function pageNum(num) {
            document.getElementById('pageNum').value = num;
            document.forms['pagination'].submit();
        }
        function Update(id) {
            document.forms['dashboard'].questionID.value = id;
            document.forms['dashboard'].action.value = 'update';
            //alert(document.forms['dashboard'].questionID.value);
            document.forms['dashboard'].submit();
        }
        function Delete(id) {
            document.forms['dashboard'].questionID.value = id;
            document.forms['dashboard'].action.value = 'delete';
            var answer = confirm("Are you sure ?");
            if (answer == true) {
                document.forms['dashboard'].submit();
            }
        }
    </script>
</html>
