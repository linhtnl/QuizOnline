<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html > 
    <head>
        <title>LMS - HOME PAGE</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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

            .login-form{
                background: #3a8d82;
                margin:  7% 25%;
                border: 1px solid white;
                color: white;
                border-radius: 8px;
                height: 220px;
            }
            .login-form a{
                color: white;
                font-style: italic
            }
            .login-form span{
                color: red;
                font-style: italic;
                margin-left: 170px;
                font-weight: bold;
            }
            .content{
                margin:10px 20px;
            }
            .content input{
                padding: 2% 2%;
                height: 40px;
                width: 100%;
            }
            .col-sm-5{
                margin:  5px 0;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="login-form">
            <div class="content">
                <h2>Login into your account</h2>
                <form action="UserController" method="POST">
                    <div class="row">
                        <div class="col-sm-5">Username</div>
                        <div class="col-sm-5">Password</div>
                        <div class="col-sm-1"></div>
                    </div>
                    <div class="row">
                        <div class="col-sm-5">
                            <input type="email" name="email" required="" value="${sessionScope.ACC.email}"/>
                        </div>
                        <div class="col-sm-5">
                            <input type="password" name="password" required=""/>
                        </div>
                        <div class="col-sm-2" style="margin:  5px 0;">
                            <input type="hidden" value="login" name="action"/>
                            <button class="btn btn-light" type="submit">
                                Log in
                            </button>
                        </div>

                    </div>
                </form>
                <a href="register.jsp" >Create new account</a>
                <span>${sessionScope.ACC.error}</span>
            </div>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
