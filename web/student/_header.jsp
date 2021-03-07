<%-- 
    Document   : _header
    Created on : Mar 4, 2021, 11:01:19 PM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

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
    </div>

</header>
 