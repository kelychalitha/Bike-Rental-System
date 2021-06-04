<%-- 
    Document   : homePage
    Created on : August 15, 2020, 10:01:54 PM
    Author     : Kely
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String toPage = (request.getParameter("page") != null ? request.getParameter("page") : ""); %>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!-->
<html class="no-js" lang="en"><!--<![endif]-->
    <head>
        <title>Home<% out.println((toPage.isEmpty() == true) ? "" : " > " + toPage); %></title>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge ,chrome=1">
        <meta name="keywords" content="css3, css-only, fullscreen, background, slideshow, images, content" >
        <meta name="author" content="K.C. Weerasooryan" >
        <link rel="shortcut icon" href="../favicon.ico"/>
        <link href="https://fonts.googleapis.com/css?family=ZCOOL+XiaoWei" rel="stylesheet" />
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <link href="./css/homepage.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            $(function () {
                $("#fromdate").datepicker({
                    dateFormat: "yy-mm-dd",
                    minDate: 0,
                    maxDate: "+2M",
                    setDate: new Date(),
                    onSelect: function(selDate) {
                        $('#todate').datepicker('option', 'minDate', selDate);
                  }
                });
                $("#todate").datepicker({
                    dateFormat: "yy-mm-dd",
                    minDate: 0,
                    maxDate: "+2M",
                    setDate: new Date()
                });
                $("#todate").on("change", function () {
                    var diff = Math.floor((Date.parse($("#todate").val()) - Date.parse($("#fromdate").val())) / 86400000);
                    console.log(diff);
                    if (diff.valueOf() <= 0) {
                        diff = 0;
                    }
                    $("#days").val("" + diff + "");
                    $("#hours").val("" + (12 * diff) + "");
                    $("#hours_price").val("" + ((12 * $("#price").val()) * diff) + "");
                    $("#days_price").val("" + ($("#price").val() * diff) + "");
                });
            });
        </script>
    </head>
    <%
        if (toPage.equals("home")) {  %>
    <body>
        <jsp:include page="menu.jsp" />
        <jsp:include page="homePage.jsp" />
        <% } else if (toPage.equals("category")) {  %>
        <jsp:include page="categoryPage.jsp" />
        <% } else if (toPage.equals("booking")) {  %>
    <body class="body_bookPage">
        <jsp:include page="menu.jsp" />
        <jsp:include page="booking.jsp" />
        <% } else if (toPage.equals("feedback")) {  %>
    <body class="body_feedPage">
        <jsp:include page="menu.jsp" />
        <jsp:include page="feedback.jsp" />
        <% } else if (toPage.equals("login")) {  %>
        <jsp:include page="login.jsp" />
        <% } else if (toPage.equals("register")) {  %>
        <jsp:include page="register.jsp" />
        <% } else if (toPage.equals("registration")) {  %>
        <jsp:include page="menu.jsp" />
        <% } else if (toPage.equals("logout")) {  %>
        <jsp:include page="LogoutServlet" />
        <% } else if (toPage.equals("rental_procedure")) {  %>
        <jsp:include page="rentalProcedure.jsp" />
        <% } else if (toPage.equals("aboutus")) {  %>
        <jsp:include page="aboutPage.jsp" />
        <% } else if (toPage.equals("AdminEdit")) {  %>
        <jsp:include page="adminEdit.jsp" />
        <% } else { %>
    <body>
        <jsp:include page="menu.jsp" />
        <jsp:include page="homePage.jsp" />
        <% }
            //}
        %>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body> 
</html>