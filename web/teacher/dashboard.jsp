<%-- 
    Document   : dashboard
    Created on : Mar 4, 2021, 11:17:35 PM
    Author     : ASUS
--%>

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

        <div class="container"><br>
            <button class="btn btn-success create-button"><img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJDYXBhXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgNTEyIDUxMiIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNTEyIDUxMjsiIHhtbDpzcGFjZT0icHJlc2VydmUiPg0KPGc+DQoJPGc+DQoJCTxwYXRoIGQ9Ik0yNTYsMEMxMTQuODMzLDAsMCwxMTQuODMzLDAsMjU2czExNC44MzMsMjU2LDI1NiwyNTZzMjU2LTExNC44NTMsMjU2LTI1NlMzOTcuMTY3LDAsMjU2LDB6IE0yNTYsNDcyLjM0MQ0KCQkJYy0xMTkuMjc1LDAtMjE2LjM0MS05Ny4wNDYtMjE2LjM0MS0yMTYuMzQxUzEzNi43MjUsMzkuNjU5LDI1NiwzOS42NTlTNDcyLjM0MSwxMzYuNzA1LDQ3Mi4zNDEsMjU2UzM3NS4yOTUsNDcyLjM0MSwyNTYsNDcyLjM0MXoNCgkJCSIvPg0KCTwvZz4NCjwvZz4NCjxnPg0KCTxnPg0KCQk8cGF0aCBkPSJNMzU1LjE0OCwyMzQuMzg2SDI3NS44M3YtNzkuMzE4YzAtMTAuOTQ2LTguODY0LTE5LjgzLTE5LjgzLTE5Ljgzcy0xOS44Myw4Ljg4NC0xOS44MywxOS44M3Y3OS4zMThoLTc5LjMxOA0KCQkJYy0xMC45NjYsMC0xOS44Myw4Ljg4NC0xOS44MywxOS44M3M4Ljg2NCwxOS44MywxOS44MywxOS44M2g3OS4zMTh2NzkuMzE4YzAsMTAuOTQ2LDguODY0LDE5LjgzLDE5LjgzLDE5LjgzDQoJCQlzMTkuODMtOC44ODQsMTkuODMtMTkuODN2LTc5LjMxOGg3OS4zMThjMTAuOTY2LDAsMTkuODMtOC44ODQsMTkuODMtMTkuODNTMzY2LjExNCwyMzQuMzg2LDM1NS4xNDgsMjM0LjM4NnoiLz4NCgk8L2c+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8L3N2Zz4NCg==" width="20px" height="20px" style="margin-right: 5px"/>Create Question</button><br>
            <h2>Question Bank</h2>   
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
                    <tr>
                        <td class="table-body-number">1</td>
                        <td class="table-body-content"><p>sjhd abiuhuibiuasehfvieourtvh eur ghergi uherg uiaerghailerg herlgi uahrg </p></td>
                        <td>DOE</td>
                        <td><span class="badge badge-danger">Deleted</span></td>
                        <td><button class="btn btn-primary">Update</button> </td>
                        
                        <td><button class="btn btn-danger">Delete</button></td>
                    </tr>
                    
                </tbody>
            </table>


        </div>
        <%@include file="_footer.jsp" %>
    </body>
</html>
