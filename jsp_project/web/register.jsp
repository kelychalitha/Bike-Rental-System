<%-- 
    Document   : index
    Created on : August 8, 2020, 11:08:46 AM
    Author     : Kely
--%>

    <body class="body_login">
        <jsp:include page="menu.jsp" />
        <div class="d-flex align-items-center flex-column justify-content-center h-100">
            <div class="box">
                <img class="avatar" src="img/iconReg.png">
                <h1>Register Account</h1>
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
                <form action="RegisterServlet" method="post">
                    <p>Username</p>
                    <input type="text" placeholder="Username" name="name" required>
                    <p>User_email</p>
                    <input type="text" placeholder="Useremail" name="email" required>
                    <p>Password</p>
                    <input type="password" placeholder="Password" name="password" required>
                    <input type="submit" value="Register">
                    <a href="?page=login">Already have Account?</a>
                </form>
            </div>
        </div>