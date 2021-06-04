<%-- 
    Document   : index
    Created on : August 14, 2020, 12:08:46 AM
    Author     : Kely
--%>
<%@page import="java.sql.*" %>
<%
            String uname=(String)session.getAttribute("logUser");
            String admin=(String)session.getAttribute("logAdmin");
                
            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;
            String toCat=(request.getParameter("cat")!=null?request.getParameter("cat"):"") ;
            if(toCat.isEmpty()!=true){
                    String name = null;
                    String b_class = null;
                    String longdesc = null;
                    String faq = null;
                    try {
                        connection = BikeRental.ConnectionPro.getConnection();
                        statement = connection.createStatement();
                        String sql = "select * from category where category_id='"+toCat+"'";
                        resultSet = statement.executeQuery(sql);
                        while (resultSet.next()) {
                                name = resultSet.getString("name");
                                b_class = resultSet.getString("b_class");
                                longdesc = resultSet.getString("long_desc");
                                faq = resultSet.getString("faq");
                        }
                        connection.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    if(name==null){
                        %>
        <META http-equiv="refresh" content="10;URL=index.jsp?page=category">
         <body class="body_catPage">
            <jsp:include page="menu.jsp" />
            <div class="container bContainer">
                        <div class="alert alert-danger h-100">
                            No data found for this category!
                        </div>
            </div>
                        <%
                    }else{

%>
        <body class="<% out.println(b_class); %>">
            <jsp:include page="menu.jsp" />
            <div class="container bContainer">
                <h1><% out.println(name); %></h1>
                <br />
                <div class="content">
                    <p><% out.println(longdesc); %><p>
                </div>
                <br />
                <h3>Rental Details</h3>
                <div class="d-flex flex-row justify-content-around flex-wrap">
                    <%
                        try {
                            connection = BikeRental.ConnectionPro.getConnection();
                            statement = connection.createStatement();
                            String sql = "select * from bikes where category_id='"+toCat+"'";
                            resultSet = statement.executeQuery(sql);
                            while (resultSet.next()) {
                    %>
                    <div class="d-flex flex-column">
                        <div class="gallery">
                            <a target="_blank" href="<%=resultSet.getString("bike_image")%>">
                                <img src="<%=resultSet.getString("bike_image")%>" alt="<%=resultSet.getString("bike_name")%>" width="600" height="400">
                            </a>
                            <div class="desc">
                                <h3><%=resultSet.getString("bike_name")%></h3>
                                <%=resultSet.getString("bike_description")%>
                                <h3><%=resultSet.getBigDecimal("price",2)%>$ per <%=resultSet.getString("time_unit")%></h3>
                                <br />
                                <a class="booking_button" href="?page=booking&cat=<%=resultSet.getString("category_id")%>&bike=<%=resultSet.getString("bike_id")%>">Book this bike</a></br></br></br>
                                <a class="booking_button" href="?page=feedback&cat=<%=resultSet.getString("category_id")%>&bike=<%=resultSet.getString("bike_id")%>">Add feedback</a>
                            </div>
                            <%  if(uname!=null && !uname.isEmpty() && admin!=null && admin.equals("Yes")){
                        %>
                        <hr><br />
                        <a class="booking_button" href="?page=AdminEdit&what=bike&doAction=upd_bike&bike_id=<%=resultSet.getString("bike_id")%>">> Update bike</a><br /><br /><br />
                        <a class="booking_button" href="BikeServlet?doSth=del_bike&category_id=<%=resultSet.getString("category_id")%>&bike_id=<%=resultSet.getString("bike_id")%>">- Delete this bike</a><br /><br />
                        <%
                        }
                        %>
                        </div>
                    </div>
                    <% }
                            connection.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        } %> 
                </div>
                <%  if(uname!=null && !uname.isEmpty() && admin!=null && admin.equals("Yes")){
                        %>
                        <br />
                        <a class="booking_button" href="?page=AdminEdit&what=bike&doAction=add_bike">+ Add new bike</a><br /><br />
                        <%
                        }
                        %>
                <br />
                <% if(faq.isEmpty()!=true){ %>
                <div class="content">
                    <% out.println(faq); %>
                </div>
                <% } %>
            </div>
            <% }}else{ %>
    <body class="body_catPage">
        <jsp:include page="menu.jsp" />
        <div class="container bContainer">
            <h2>Category of Bikes</h2>
            <h4>Now available:</h4>
            <div class="d-flex flex-row justify-content-around flex-wrap">
                <%
                    try {
                        connection = BikeRental.ConnectionPro.getConnection();
                        statement = connection.createStatement();
                        String sql = "select * from category";
                        resultSet = statement.executeQuery(sql);
                        while (resultSet.next()) {
                %>
                <div class="d-flex flex-column">
                    <div class="gallery img">
                        <a href="?page=category&cat=<%=resultSet.getString("category_id")%>">
                            <img src="<%=resultSet.getString("image_url")%>" alt="<%=resultSet.getString("name")%>" width="600" height="400">
                        </a>
                        <div class="desc"><h2><%=resultSet.getString("name")%></h2>
                                <%=resultSet.getString("descr")%>
                            <a href="?page=category&cat=<%=resultSet.getString("category_id")%>"><br />Read more</a>
                        </div>
                        <%  if(uname!=null && !uname.isEmpty() && admin!=null && admin.equals("Yes")){
                        %>
                        <hr>
                        <br />
                        <a class="booking_button" href="?page=AdminEdit&what=cat&doAction=upd_cat&cat_id=<%=resultSet.getString("category_id")%>">> Update category</a><br /><br /><br />
<a class="booking_button" href="BikeServlet?doSth=del_cat&category_id=<%=resultSet.getString("category_id")%>">- Delete category</a><br /><br />
                        <%
                        }
                        %>
                    </div>
                </div>
                <% }
                        connection.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    } %>
            </div>
            <%  if(uname!=null && !uname.isEmpty() && admin!=null && admin.equals("Yes")){
                        %>
                        <br />
                        <a class="booking_button" href="?page=AdminEdit&what=cat&doAction=add_cat">+ Add category</a>
                        <%
                        }
                        %>
        </div>
        <%
        }
        %>