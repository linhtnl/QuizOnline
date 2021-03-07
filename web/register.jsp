<%-- 
    Document   : register.jsp
    Created on : Mar 4, 2021, 6:19:26 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <title>Registration</title>
        <style>
            header .header-logo{
                background: #4ba89c;
                padding-top: 10px;
                padding-bottom: 30px;
                padding-left: 170px; 
            }
            .header-bottom{
                padding: 21px;
                background: #3a8d82;
            }
            img{
                border: 0 none;
                height: auto;
                max-width: 100%;
                vertical-align: middle;
            }
            footer{
                padding: 30px 40px 30px 170px;
                background: #4ba89c;
                color: white;
                height: 230px;
            }
            footer a{
                color: white;
                text-decoration: none;
            }
            footer a:hover{
                color: white;
            }       
            .form{
                padding: 2%;
            }
            .form h2{
                text-align: center;
                text-transform: uppercase;
                padding-bottom: 10px
            }
            .form-item {
                padding: 15px 15%;
            }
            .form-item-button{
                padding-left: 50%;
            }
            .form-item-button button{
                margin-right: 20px;
            }
            .form-item input{
                width: 300px;
                border-radius: 7px;
            }
            .form-item label{
                margin-right: 10px;
                font-weight: bold;
                font-size: 20px;
                width: 190px;
                text-align: right;
            }
            span{
                color: red;
                font-style: italic;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="container">
            <div class="form">
                <h2>Registration Form</h2>
                <form action="UserController" method="POST" name="regis">
                    <div class="form-item">
                        <label>Email: </label>
                        <input type="email" name="email" required="" id="email"/>
                        <span id="email_ERR"></span>
                    </div>
                    <div class="form-item">
                        <label>Name: </label>
                        <input type="text" name="name" required="" id="name"/>
                        <span id="name_ERR"></span>
                    </div>
                    <div class="form-item">
                        <label>Password: </label>
                        <input type="password" name="password" required="" id="pass"/>
                        <span id="pass_ERR"></span>
                    </div>
                    <div class="form-item">
                        <label>Confirm Password: </label>
                        <input type="password" name="confirmPassword" required="" id="confirmPass"/>
                        <span id="confirmPass_ERR"></span>
                      
                    </div>
                    <div class="form-item">
                        <span style="padding-left: 300px;">${sessionScope.ACC.error}</span>  
                    </div>
                    <input type="hidden" name="action" value="register"/>
                    <div class="form-item-button">
                        
                        <button class="btn btn-secondary" type="button" onclick="Back()">Back</button>
                        <button class="btn btn-primary" type="button" onclick="Register()">Register</button>
                    </div>
                </form>
            </div>
            
        </div>
        <%@include file="footer.jsp" %>
    </body>
    <script>
        function Back(){
            window.location.href="index.jsp";
        }
        function clear(){
            document.getElementById('email_ERR').innerHTML ='';
            document.getElementById('name_ERR').innerHTML='';
            document.getElementById('pass_ERR').innerHTML='';
            document.getElementById('confirmPass_ERR').innerHTML='';
        }
        function validation(){
            clear();
            var flag=0;
            var regex =  "^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$";
            //Email
            var email = document.getElementById('email').value;
            if(email.length ==0 ){
                document.getElementById('email_ERR').innerHTML = 'Input please!';
                flag=1;
            }else if (!email.match(regex)) {
                document.getElementById('email_ERR').innerHTML = 'Wrong email format!';
                flag=1;
            }
            //Name
            var name = document.getElementById('name').value;
            if(name.length == 0 ){
                document.getElementById('name_ERR').innerHTML='Input please!';
                flag=1;
            }
            //Pass
            var pass = document.getElementById('pass').value;
            if(pass.length == 0){
                document.getElementById('pass_ERR').innerHTML='Input please!';
                flag=1;
            }
            //Cònirm
            var confirmPass = document.getElementById('confirmPass').value;
            if(confirmPass != pass){
                document.getElementById('confirmPass_ERR').innerHTML='Not match!';
                flag=1;
            }
            return flag;
        }
        function Register(){
            var check = validation();
            if(check!=1){
                document.forms['regis'].submit();
            }
        }
    </script>
</html>
