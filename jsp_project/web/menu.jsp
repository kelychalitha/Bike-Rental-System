<%-- 
    Document   : menu
    Created on : August 16, 2020, 2:52:12 PM
    Author     : Kely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
    <a class="navbar-brand" href="?page=home">Turbo Bike</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav ml-auto">
        <li class="nav-item">
          <a class="nav-link" href="?page=home">Home</a>
        </li>
        <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Category
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="?page=category">Types of Bike Rental</a>
          <a class="dropdown-item" href="?page=rental_procedure">Rental Procedure</a>
        </div>
      </li>
        <li class="nav-item">
          <a class="nav-link" href="?page=booking">Booking</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="?page=aboutus">About Us</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="?page=feedback">Feedback</a>
        </li>
        <% String uname=(String)session.getAttribute("logUser");
                    if(uname==null||uname.isEmpty()){
                        %>
        <li class="nav-item">
          <a class="nav-link" href="?page=login">Login</a>
        </li>
        <%
                    }else{ %>
        <li class="nav-item">
             |  <a class="navbar-text" href="LogoutServlet">Logout, ${sessionScope['logUser']}</a>
        </li>
        <% } %>
      </ul>
    </div>
  </div>
</nav>
