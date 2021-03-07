<%-- 
    Document   : _header
    Created on : Mar 4, 2021, 11:01:19 PM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script>
    $(document).ready(function() {
        var status = document.getElementById('status').value;
        var subId = document.getElementById('subID').value;
        if (status == "") {
            document.getElementById('status_none').selected = true;
        } else if (status == '0') {
            document.getElementById('status_0').selected = true;
        } else if (status == "1") {
            document.getElementById('status_1').selected = true;
        }
        if (subId == "") {
            document.getElementById('subject_none').selected = true;
        } else {
            document.getElementById(subId).selected = true;
        }
    });
</script>
<header>

    <div>
        <div class="header-logo">
            <a href="http://lms-undergrad.fpt.edu.vn">
                <img src="//lms-undergrad.fpt.edu.vn/pluginfile.php/1/theme_eguru/logo/1596867874/lo_fug.jpg" width="183" height="67" alt="Eguru">
            </a>
            <div class="header-right">
                <form action="../UserController" method="POST">
                    <input type="hidden" value="logout" name="action"/>
                    <button class="btn btn-light">Logout</button>
                </form>          
            </div>
        </div> 
    </div>        

    <div class="header-bottom">
        <label>Hello ${sessionScope.ACC.username}!</label>

        <div class="header-bottom-right">
            <form action="../QuestionController" method="post">
                <select name="subject" >
                    <option id="subject_none" value="" >Subject</option>
                    <c:forEach items="${sessionScope.listSubject}" var="dto" >                
                        <option id="${dto.id}" value="${dto.id}">${dto.id} - ${dto.name}</option>
                    </c:forEach>             
                </select>
                <select name="status" >
                    <option id="status_none" value="">Status</option>
                    <option id="status_0" value="0">Deleted</option>
                    <option id="status_1" value="1">Available</option>
                </select>
                <input type="text" name="txtSearch" value="${sessionScope.searchInfo.content}" placeholder="content of question" />
                <button class="btn btn-secondary">Search</button>
                <input  type="submit" class="btn btn-primary " id="input-button" name="action" value="Get All"/>
                <input type="hidden" value="search" name="action" />
                <input type="hidden" id="status" value="${sessionScope.searchInfo.status}"/>
                <input type="hidden" id="subID" value="${sessionScope.searchInfo.subID}" />
            </form>
        </div>


    </div>

</header>
