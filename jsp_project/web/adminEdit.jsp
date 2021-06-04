<%-- 
    Document   : index
    Created on : August 13, 2020, 12:08:46 AM
    Author     : Kely
--%>
<%@page import="org.springframework.beans.factory.parsing.ParseState.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%
    String uname = (String) session.getAttribute("logUser");
    String admin = (String) session.getAttribute("logAdmin");
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<body class="body_catPage">
    <jsp:include page="menu.jsp" />
    <div class="container bContainer">
        <div class="content">
            <%
                String what = (request.getParameter("what") != null ? request.getParameter("what") : "");
                String doA = (request.getParameter("doAction") != null ? request.getParameter("doAction") : "");
                Map<String, String> unit_arr = new HashMap<>();
                unit_arr.put("hour", "Hour");
                unit_arr.put("day", "Day");
                unit_arr.put("week", "Week");
                unit_arr.put("month", "Month");

                if (what.isEmpty() != true) {
                    String[] safe_actions = new String[]{"bike", "cat", "user"};
                    String[] safe_actions2 = new String[]{"add_bike", "upd_bike", "add_cat", "upd_cat", "upd_user"};
                    // Convert String Array to List
                    List<String> list = Arrays.asList(safe_actions);
                    List<String> list2 = Arrays.asList(safe_actions2);
                    if (list.contains(what)) {
                        if (what.equals("bike") && doA.isEmpty() != true && list2.contains(doA)) {
                            if (doA.equals("add_bike")) {
                                Map<Integer, String> cat_arr = new HashMap<>();
                                try {
                                    connection = BikeRental.ConnectionPro.getConnection();
                                    statement = connection.createStatement();
                                    String sql = "select * from category";
                                    resultSet = statement.executeQuery(sql);
                                    while (resultSet.next()) {
                                        cat_arr.put(resultSet.getInt("category_id"), resultSet.getString("name"));
                                    }
                                    connection.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }

            %>
            <h3>Add a new bike</h3>
            <form action="BikeServlet" method="post">
                <input name="doSth" type="hidden" value="add_bike">
                <p>Bike category</p>
                <select id="category_id" name="category_id">
                    <% for (Map.Entry<Integer, String> pair : cat_arr.entrySet()) { %>
                    <option value=<% out.println(String.valueOf(pair.getKey())); %>><% out.println(pair.getValue()); %></option>
                    <% } %>
                </select>
                <p>Bike name</p>
                <input id="bike_name" type="text" placeholder="bike_name" name="bike_name" required>
                <p>Bike description</p>
                <textarea id="bike_description" rows="4" cols="50" placeholder="Brief description under bike name" name="bike_description" required></textarea>
                <p>Bike image url</p>
                <input id="bike_image" type="text" placeholder="./img/imagefilename.jpg" name="bike_image" required>
                <p>Bike price (as 0.05)</p>
                <input id="price" type="text" placeholder="0.05" name="price" required>
                <p>Bike price unit</p>
                <select id="time_unit" name="time_unit" required>
                    <% for (Map.Entry<String, String> pair : unit_arr.entrySet()) { %>
                    <option value=<% out.println(String.valueOf(pair.getKey())); %>><% out.println(pair.getValue()); %></option>
                    <% } %>
                </select>
                <br/><br/>
                <input id="submit" type="submit" value="Add bike">
            </form>
            <%
            } else if (doA.equals("upd_bike")) {
                Map<Integer, String> cat_arr = new HashMap<>();
                try {
                    connection = BikeRental.ConnectionPro.getConnection();
                    statement = connection.createStatement();
                    String sql = "select * from category";
                    resultSet = statement.executeQuery(sql);
                    while (resultSet.next()) {
                        cat_arr.put(resultSet.getInt("category_id"), resultSet.getString("name"));
                    }
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                String bike_id = request.getParameter("bike_id");
                int bike_id2 = 0;
                if (bike_id != null && bike_id.length() > 0) {
                    bike_id2 = Integer.parseInt(bike_id, 10);
                }
                try {
                    connection = BikeRental.ConnectionPro.getConnection();
                    statement = connection.createStatement();
                    String sql = "select * from bikes where bike_id='" + bike_id2 + "' limit 1";
                    resultSet = statement.executeQuery(sql);
                    while (resultSet.next()) {

            %>
            <h3>Update bike</h3>
            <form action="BikeServlet" method="post">
                <input name="doSth" type="hidden" value="upd_bike">
                <input name="bike_id" type="hidden" value=<% out.println(resultSet.getInt("bike_id")); %>>
                <p>Bike category</p>
                <select id="category_id" name="category_id">
                    <% for (Map.Entry<Integer, String> pair : cat_arr.entrySet()) { %>
                    <option value=<% out.println(String.valueOf(pair.getKey())); %> <% out.println((resultSet.getInt("category_id") == pair.getKey() ? "selected" : "")); %>><% out.println(pair.getValue()); %></option>
                    <% } %>
                </select>
                <p>Bike name</p>
                <input id="bike_name" type="text" placeholder="bike_name" name="bike_name" value="<% out.println(resultSet.getString("bike_name")); %>" required>
                <p>Bike description</p>
                <textarea id="bike_description" rows="4" cols="50" placeholder="Brief description under bike name" name="bike_description" required><% out.println(resultSet.getString("bike_description")); %></textarea>
                <p>Bike image url</p>
                <input id="bike_image" type="text" placeholder="./img/imagefilename.jpg" name="bike_image" value="<% out.println(resultSet.getString("bike_image")); %>" required>
                <p>Bike price (as 0.05)</p>
                <input id="price" type="text" placeholder="0.05" name="price" value="<% out.println(resultSet.getBigDecimal("price", 2)); %>" required>
                <p>Bike price unit</p>
                <select id="time_unit" name="time_unit" required>
                    <% for (Map.Entry<String, String> pair : unit_arr.entrySet()) { %>
                    <option value=<% out.println(String.valueOf(pair.getKey())); %>  <% out.println((resultSet.getString("time_unit") == pair.getKey() ? "selected" : "")); %>><% out.println(pair.getValue()); %></option>
                    <% } %>
                </select>
                <br/><br/>
                <input id="submit" type="submit" value="Update bike">
            </form>
            <%
                    }
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }

            } else {
            %>
            <META http-equiv="refresh" content="10;URL=index.jsp">
            <div class="alert alert-info">
                No allowed action selected, redirecting back to home-page!
            </div>
            <%
                    }
                }
                if (what.equals("cat") && doA.isEmpty() != true && list2.contains(doA)) {
                    if (doA.equals("add_cat")) {

            %>
            <h3>Add a new category</h3>
            <form action="BikeServlet" method="post">
                <input name="doSth" type="hidden" value="add_cat">
                <p>Category CSS class</p>
                <input id="b_class" type="text" placeholder="body_catPage" name="b_class" value="body_catPage" required /><br />
                (NB! You need to add this separately in CSS prior to adding here - else default css class can be used!)<br /><br />
                <p>Category name</p>
                <input id="name" type="text" placeholder="Category name" name="name" required /><br />
                <p>Category short description</p>
                <textarea id="desc" rows="4" cols="50" placeholder="Brief description under category name" name="desc" required></textarea>
                <p>Category long description</p>
                <textarea id="long_desc" rows="8" cols="80" placeholder="Long description on category page" name="long_desc" required></textarea>
                <p>Category image url</p>
                <input id="image_url" type="text" placeholder="./img/imagefilename.jpg" name="image_url" required />
                <p>Category FAQ</p>
                <textarea id="faq" rows="8" cols="80" placeholder="Text-block on category page in footer - May be empty!" name="faq"></textarea>
                <br/><br/>
                <input id="submit" type="submit" value="Add category">
            </form>
            <%            } else if (doA.equals("upd_cat")) {

                String cat_id = request.getParameter("cat_id");
                int cat_id2 = 0;
                if (cat_id != null && cat_id.length() > 0) {
                    cat_id2 = Integer.parseInt(cat_id, 10);
                }
                try {
                    connection = BikeRental.ConnectionPro.getConnection();
                    statement = connection.createStatement();
                    String sql = "select * from category where category_id='" + cat_id2 + "' limit 1";
                    resultSet = statement.executeQuery(sql);
                    while (resultSet.next()) {

            %>
            <h3>Update category</h3>
            <form action="BikeServlet" method="post">
                <input name="doSth" type="hidden" value="upd_cat" />
                <input name="category_id" id="category_id" type="hidden" value=<% out.println(resultSet.getInt("category_id"));%>>
                <p>Category CSS class</p>
                <input id="b_class" type="text" placeholder="body_catPage" name="b_class" value="<%=resultSet.getString("b_class")%>" required /><br />
                (NB! You need to add this separately in CSS prior to adding here - else default css class can be used!)<br /><br />
                <p>Category name</p>
                <input id="name" type="text" placeholder="Category name" name="name" value="<%=resultSet.getString("name")%>" required /><br />
                <p>Category short description</p>
                <textarea id="desc" rows="4" cols="50" placeholder="Brief description under category name" name="desc" required><%=resultSet.getString("descr")%></textarea>
                <p>Category long description</p>
                <textarea id="long_desc" rows="8" cols="80" placeholder="Long description on category page" name="long_desc" required><%=resultSet.getString("long_desc")%></textarea>
                <p>Category image url</p>
                <input id="image_url" type="text" placeholder="./img/imagefilename.jpg" name="image_url" value="<%=resultSet.getString("image_url")%>" required />
                <p>Category FAQ</p>
                <textarea id="faq" rows="8" cols="80" placeholder="Text-block on category page in footer - May be empty!" name="faq"><%=resultSet.getString("faq")%></textarea>
                <br/><br/>
                <input id="submit" type="submit" value="Update category">
            </form>
            <%
                    }
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }

            } else {
            %>
            <META http-equiv="refresh" content="10;URL=index.jsp">
            <div class="alert alert-info">
                No allowed action selected, redirecting back to home-page!
            </div>
            <%
                    }
                }
            } else {
            %>
            <META http-equiv="refresh" content="10;URL=index.jsp">
            <div class="alert alert-info">
                No allowed action selected, redirecting back to home-page!
            </div>
            <%
                }
            } else {
            %>
            <META http-equiv="refresh" content="10;URL=index.jsp">
            <div class="alert alert-info">
                No allowed action selected, redirecting back to home-page!
            </div>
            <%
                }
            %>
        </div>
    </div>
