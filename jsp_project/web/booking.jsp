<%-- 
    Document   : booking
    Created on : Auguest 19,2020, 7:29:51 AM
    Author     : Kely
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*" import="java.math.BigDecimal"%>
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
    <h1>Booking page</h1>
    <%  if (uname != null && !uname.isEmpty() && Integer.toString(uIdd) != null && !Integer.toString(uIdd).isEmpty()) {
            if (toBike != null && toBike > 0) {
                String bname = null;
                String bdesc = null;
                Integer cid = null;
                Integer bid = null;
                BigDecimal bprice = null;
                String bunit = null;
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
                        bprice = resultSet.getBigDecimal("price", 2);
                        bunit = resultSet.getString("time_unit");
                    }
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                String bunit2 = bunit.substring(0, 1).toUpperCase() + bunit.substring(1).toLowerCase();

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
        NB! BikeRental bikes hours price per booking is calculated by approx usage of 12h per day<br />
        If day price is shown - it will be calculated price per day!<br /><br />
        <form action="<%= request.getContextPath()%>/Booking" method="post">
            <input type="hidden" name="doSth" id="doSth" value="add_booking">
            <input type="hidden" name="price" id="price" value="<% out.println(bprice); %>">
            <input type="hidden" name="UserId" id="UserId" value=<% out.println(uIdd); %>>
            <input type="hidden" name="CategoryId" id="CategoryId" value=<% out.println(cid); %>>
            <input type="hidden" name="BikeId" id="BikeId" value=<% out.println(bid); %>>
            <input type="hidden" name="bUnit" id="bUnit" value=<% out.println(bunit); %>>
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
                    <td><% out.println(bdesc); %></td>
                </tr>
                <tr>
                    <td>Price per <% out.println(bunit2); %>:</td>
                    <td><% out.println(bprice); %> (local currency)</td>
                </tr>
                <tr>
                    <td>From date</td>
                    <td><input type="text" name="Fromdate" id="fromdate" /></td>
                </tr>
                <tr>
                    <td>To date</td>
                    <td><input type="text" name="Todate" id="todate" /></td>
                </tr>
                <tr>
                    <td><% out.println(bunit2 + "s"); %> for rent:</td>
                    <td><% if (bunit.equals("hour")) { %>
                        <input type="text" name="Hours" id="hours" value="0" readonly />
                        <% } else if (bunit.equals("day")) { %>
                        <input type="text" name="Days" id="days" value="0" readonly />
                        <% } %></td>
                </tr>
                <tr>
                    <td><% out.println(bunit2 + "s"); %> sum for rental period:</td>
                    <td><% if (bunit.equals("hour")) { %>
                        <input type="text" name="hours_price" id="hours_price" value="0" readonly />
                        <% } else if (bunit.equals("day")) { %>
                        <input type="text" name="days_price" id="days_price" value="0" readonly /> 
                        <% } %> (local currency))</td>
                </tr>
                <tr>
                    <td>Booking User:</td>
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
        //no bike selected, show bookings!
        Integer bookingId = null;
        String fromDate = null;
        String toDate = null;
        Integer userID = null;
        Integer bikeID = null;
        Integer catID = null;
        String paid = null;
        String paidDate = null;
        BigDecimal bookingSum = null;
        BigDecimal paidSum = null;
        String sql2 = null;
        Integer colSpan = 9;
    %>
    <div class="content">On this page You can see Your existing bookings<br />
        If no bookings found - To book a bike, please select bikes from under categories!<br /><br />
        NB! Payment information you will receive by email after we have confirmed booking.
        <hr>
        <table style="width: 100%;">
            <tr>
                <th>ID</th>
                <th>From</th>
                <th>To</th>
                <th>User</th>
                <th>Bike number</th>
                <th>Bike name</th>
                <th>Booking Sum</th>
                <th>Paid sum</th>
                <th>Paid date</th>
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
                    if (admin != null && admin.equals("Yes")) {
                        sql2 = "select * from booking order by booking_id DESC";
                    } else {
                        sql2 = "select * from booking where user_id='" + uIdd + "' order by booking_id DESC";
                    }
                    resultSet = statement.executeQuery(sql2);
                    if (resultSet.next() == false) {
            %>
            <tr><td colspan="<% out.println(colSpan); %>"><center><h2>No bookings found</h2></center></td></tr>
                <%
                } else {
                    do {
                        bookingId = resultSet.getInt("booking_id");
                        fromDate = resultSet.getString("from_date");
                        toDate = resultSet.getString("to_date");
                        userID = resultSet.getInt("user_id");
                        bikeID = resultSet.getInt("bike_id");
                        catID = resultSet.getInt("category_id");
                        paid = resultSet.getString("paid");
                        paidDate = resultSet.getString("paid_date");
                        bookingSum = resultSet.getBigDecimal("booking_sum", 2);
                        paidSum = resultSet.getBigDecimal("paid_sum", 2);
                        String sql3 = "select * from user where id='" + userID + "'";
                        String sql4 = "select * from bikes where bike_id='" + bikeID + "'";;
                        String uuname = null;
                        String umail = null;
                        String bname = null;
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
                                umail = resultSet2.getString("email");
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
                            }
                            connection3.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                %>
            <tr>
                <td><% out.println(bookingId); %></td>
                <td><% out.println(fromDate.substring(0, 10)); %></td>
                <td><% out.println(toDate.substring(0, 10)); %></td>
                <td>
                    <% out.println(uuname); %><br />
                    <% if (admin != null && admin.equals("Yes")) {
                            out.println(umail);
                        }%>
                </td>
                <td><% out.println(bikeID); %></td>
                <td><a href="index.jsp?page=category&cat=<% out.println(catID); %>"><% out.println(bname); %></a></td>
                <td><% out.println(bookingSum); %></td>
                <% if (!paid.equals("Yes")) { %>
                <td colspan="2"><center>Not paid yet</center></td>
                <% } else { %>
            <td><% out.println(paidSum); %></td>
            <td><% out.println(paidDate.substring(0, 16)); %></td>
            <% } %>
            <% if (admin != null && admin.equals("Yes")) { %>
            <td><% if (!paid.equals("Yes")) {%>
                + <a href="Booking?doSth=mark_booking&booking_id=<%=bookingId%>">Mark Paid</a><br />
                <% }%>
                - <a href="Booking?doSth=del_booking&booking_id=<%=bookingId%>">Delete</a>
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
    <div class="content">403 NO_ACCESS - this page is only for registered customers<br />Please log in to book a bike!</div>
    <meta http-equiv="refresh" content="10; url=index.jsp?page=login">
    <%
        }
    %>
</div>