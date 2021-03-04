<%-- 
    Document   : _header
    Created on : Mar 4, 2021, 11:01:19 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<header>
    <div>
        <div class="header-logo">
            <a href="http://lms-undergrad.fpt.edu.vn">
                <img src="//lms-undergrad.fpt.edu.vn/pluginfile.php/1/theme_eguru/logo/1596867874/lo_fug.jpg" width="183" height="67" alt="Eguru">
            </a>
            <div class="header-right">
                <form action="UserController" method="POST">
                    <input type="hidden" value="logout" name="action"/>
                     <button class="btn btn-light">Logout</button>
                </form>          
            </div>
        </div> 
    </div>        
    <div class="header-bottom">
        <label>Hello ${sessionScope.ACC.username}!</label>
        <div class="header-bottom-right">
            <select name="subject" >
                <option value="" >Subject</option>
                <option value="volvo">Volvo</option>
                <option value="saab">Saab</option>              
            </select>
            <select name="status" >
                <option value="">Status</option>
                <option value="0">Deleted</option>
                <option value="1">Available</option>
            </select>
            <input type="text" name="txtSearch" placeholder="content of question" />
            <button class="btn btn-secondary">Search</button>
        </div>
    </div>

</header>
