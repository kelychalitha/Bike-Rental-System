<%-- 
    Document   : feedback
    Created on : August 17, 2020, 9:25:02 AM
    Author     : Kely
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    String uname = (String) ((session.getAttribute("logUser") != null) ? session.getAttribute("logUser") : "");
    String admin = (String) ((session.getAttribute("logAdmin") != null) ? session.getAttribute("logAdmin") : "");
    int uIdd = (int) ((session.getAttribute("logId") != null) ? session.getAttribute("logId") : 0);
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    Integer toCat = Integer.parseInt((request.getParameter("cat") != null) ? request.getParameter("cat") : "0");
    Integer toBike = Integer.parseInt((request.getParameter("bike") != null) ? request.getParameter("bike") : "0");

%>
<style>
    table { 
        border-spacing: 5px;
        border: 1px solid white;
    }
    td { 
        padding: 5px;
        vertical-align: top;
    }
    tr{
        border: 1px solid white;
    }
    a {
        text-decoration: none;
        color: white;
    }

</style>
<div class="container bContainer">
    <h1>Feedback page</h1>
    <%        if (uname != null && !uname.isEmpty() && Integer.toString(uIdd) != null && !Integer.toString(uIdd).isEmpty()) {
            if (toBike != null && toBike > 0) {
                String bname = null;
                String bdesc = null;
                Integer cid = null;
                Integer bid = null;
                String bimg = null;
                try {
                    connection = BikeRental.ConnectionPro.getConnection();
                    statement = connection.createStatement();
                    String sql = "select * from bikes where bike_id='" + toBike + "'";
                    resultSet = statement.executeQuery(sql);
                    while (resultSet.next()) {
                        bid = resultSet.getInt("bike_id");
                        bname = resultSet.getString("bike_name");
                        bdesc = resultSet.getString("bike_description");
                        cid = resultSet.getInt("category_id");
                        bimg = resultSet.getString("bike_image");
                    }
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }

                if (cid != toCat) {

    %>
    <meta http-equiv="refresh" content="0; url=index.jsp?page=category">
    <%        }

        String cname = null;
        try {
            connection = BikeRental.ConnectionPro.getConnection();
            statement = connection.createStatement();
            String sql = "select * from category where category_id='" + cid + "'";
            resultSet = statement.executeQuery(sql);
            while (resultSet.next()) {
                cname = resultSet.getString("name");
            }
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <div class="content">
        Please leave Your feedback for bike:<br /><br />
        <form action="<%= request.getContextPath()%>/BikeServlet" method="post">
            <input type="hidden" name="doSth" id="doSth" value="add_feedback">
            <input type="hidden" name="u_id" id="UserId" value=<% out.println(uIdd); %>>
            <input type="hidden" name="c_id" id="CategoryId" value=<% out.println(cid); %>>
            <input type="hidden" name="b_id" id="BikeId" value=<% out.println(bid); %>>
            <table style="width: 80%">
                <tr>
                    <td width="200px">Bike Category:</td>
                    <td><% out.println(cname); %></td>
                </tr>
                <tr>
                    <td>Bike Name:</td>
                    <td><% out.println(bname); %></td>
                </tr>
                <tr>
                    <td>Bike Description:</td>
                    <td><% out.println(bdesc);%></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <a target="_blank" href="<%=bimg%>">
                            <img src="<%=bimg%>" alt="<%=bname%>" width="440" height="320">
                        </a>
                    </td>
                </tr>
                <tr>
                    <td>Title</td>
                    <td><input type="text" name="fTitle" id="fTitle" /></td>
                </tr>
                <tr>
                    <td>Feedback</td>
                    <td><textarea name="fText" id="fText" rows="6" cols="40"></textarea></td>
                </tr>
                <tr>
                    <td>User:</td>
                    <td><% out.println(uname); %></td>
                </tr>
            </table>
            <br /><br />
            <input type="reset" value="Reset" />
            <input type="submit" value="Submit" />
        </form>
    </div>
    <%
    } else {
        //no bike selected, show feedbacks!
        Integer feedbackId = null;
        String fromDate = null;
        Integer userID = null;
        Integer bikeID = null;
        Integer catID = null;
        String fTitle = null;
        String fText = null;
        String sql2 = null;
        Integer colSpan = 4;
    %>
    <div class="content">On this page You can see feedback given for bikes/service by other customers<br />
        If no feedback is found - Please add feedback for bikes from under categories!
        <hr>
        <table style="width: 100%;">
            <tr>
                <th>Date</th>
                <th>User</th>
                <th>Bike</th>
                <th width="50%">Feedback</th>
                    <% if (admin != null && admin.equals("Yes")) {
                            colSpan = (colSpan + 1);
                    %>
                <th>Edit</th>
                    <% } %>
            </tr>
            <%
                try {
                    connection = BikeRental.ConnectionPro.getConnection();
                    statement = connection.createStatement();
                    sql2 = "select * from feedback order by feedback_id DESC limit 50";
                    resultSet = statement.executeQuery(sql2);
                    if (resultSet.next() == false) {
            %>
            <tr><td colspan="<% out.println(colSpan); %>"><center><h2>No feedback found yet</h2></center></td></tr>
                <%
                } else {
                    do {
                        feedbackId = resultSet.getInt("feedback_id");
                        fromDate = resultSet.getString("date_added");
                        userID = resultSet.getInt("user_id");
                        bikeID = resultSet.getInt("bike_id");
                        catID = resultSet.getInt("category_id");
                        fTitle = resultSet.getString("feedback_title");
                        fText = resultSet.getString("feedback_text");
                        String sql3 = "select * from user where id='" + userID + "'";
                        String sql4 = "select * from bikes where bike_id='" + bikeID + "'";;
                        String uuname = null;
                        String bname = null;
                        String bimg = null;
                        Statement statement2 = null;
                        Statement statement3 = null;
                        Connection connection2 = null;
                        Connection connection3 = null;
                        ResultSet resultSet2 = null;
                        ResultSet resultSet3 = null;
                        try {
                            connection2 = BikeRental.ConnectionPro.getConnection();
                            statement2 = connection2.createStatement();
                            resultSet2 = statement2.executeQuery(sql3);
                            while (resultSet2.next()) {
                                uuname = resultSet2.getString("name");
                            }
                            connection2.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        try {
                            connection3 = BikeRental.ConnectionPro.getConnection();
                            statement3 = connection3.createStatement();
                            resultSet3 = statement3.executeQuery(sql4);
                            while (resultSet3.next()) {
                                bname = resultSet3.getString("bike_name");
                                bimg = resultSet3.getString("bike_image");
                            }
                            connection3.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                %>
            <tr>
                <td><% out.println(fromDate.substring(0, 16)); %></td>
                <% if (admin != null && admin.equals("Yes")) { %>
                <td><% out.println(uuname); %></td>
                <% } else { %>
                <td><% out.println(uuname.substring(0, 3) + "****"); %></td>
                <% } %>
                <td>
                    <a href="index.jsp?page=category&cat=<% out.println(catID); %>"><% out.println(bname);%></a><br />
                    <a target="_blank" href="<%=bimg%>">
                        <img src="<%=bimg%>" alt="<%=bname%>" width="110" height="80">
                    </a>
                </td>
                <td>
                    <b><% out.println(fTitle); %></b><br /><br />
                    <% out.println(fText); %>
                </td>
                <% if (admin != null && admin.equals("Yes")) {%>
                <td>
                    - <a href="BikeServlet?doSth=del_feedback&f_id=<%=feedbackId%>">Delete</a>
                </td>
                <% } %>
            </tr>
            <%

                        } while (resultSet.next());

                    }
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </div>
    <%
        }
    } else {
    %>
    <div class="content">403 NO_ACCESS - this page is only for registered customers<br />Please log in to send or check feedback!</div>
    <meta http-equiv="refresh" content="10; url=index.jsp?page=login">
    <%
        }
    %>
</div>