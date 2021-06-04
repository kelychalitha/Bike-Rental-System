<%-- 
    Document   : index
    Created on : August 08, 2020, 12:28:46 AM
    Author     : Kely
--%>
    <body class="body_login">
        <jsp:include page="menu.jsp" />
        <div class="container">
        <div class="d-flex align-items-center flex-column justify-content-center h-100">
            <div class="box">
                <img class="avatar" src="img/userLogin.png">
                <h1>Login Account</h1>
                <%
                    String error = (String) session.getAttribute("RegError");
                    if (error == null || error.isEmpty()) {
                    } else {
                %>
                <div class="alert alert-danger" role="alert">
                    Error: <% out.print(error); %>
                </div>
                <%
                        session.removeAttribute("RegError");
                    }
                %>
                <form action="LoginServlet" method="post">
                    <p>Username</p>
                    <input type="text" placeholder="Username" name="email" required>
                    <p>Password</p>
                    <input type="password" placeholder="Password" name="password" required>
                    <input type="submit" value="Login">
                    <!--<a href="#">Forget Password?</a><br>-->
                    <a href="?page=register">Create New Account</a>
                </form>
            </div>
        </div>
        </div>