/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BikeRental;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author kcwee
 */
public class BookingServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     * @throws java.lang.IllegalAccessException
     * @throws java.lang.InstantiationException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, IllegalAccessException, InstantiationException {
        response.setContentType("text/html;charset=UTF-8");
        String doSth = request.getParameter("doSth");
        //Double BookingSum = Double.parseDouble(request.getParameter("BookingSum"));


        /* TODO output your page here. You may use following sample code. */
        //use if else from different post action types for inserting/updating
        //1. Inserting new booking from post to booking DB with correct data
        if (doSth != null && doSth.isEmpty() == false) {
            String[] safe_actions = new String[]{"add_booking", "del_booking", "upd_booking", "mark_booking"};
            // Convert String Array to List
            List<String> list = Arrays.asList(safe_actions);
            if (list.contains(doSth)) {

                //2. Update booking in DB
                //3. If no needed post parameter is present or security check fails for safe actions, redirect to booking page
                if (doSth.equals("add_booking")) {
                    String Fromdate = request.getParameter("Fromdate");
                    String Todate = request.getParameter("Todate");
                    Integer UserId = Integer.parseInt(request.getParameter("UserId"), 10);
                    Integer CategoryId = Integer.parseInt(request.getParameter("CategoryId"), 10);
                    Integer BikeId = Integer.parseInt(request.getParameter("BikeId"), 10);
                    Double BookingSum = 0.00;
                    if (request.getParameter("bUnit").equals("hour")) {
                        BookingSum = Double.parseDouble(request.getParameter("hours_price"));
                    } else if (request.getParameter("bUnit").equals("day")) {
                        BookingSum = Double.parseDouble(request.getParameter("days_price"));
                    }
                    BookingDAO bookingModel = new BookingDAO(Fromdate, Todate, UserId, CategoryId, BikeId, BookingSum);
                    //create a database model
                    BookingDatabase saveBooking = new BookingDatabase(ConnectionPro.getConnection());
                    if (saveBooking.saveBooking(bookingModel)) {
                        response.sendRedirect("index.jsp?page=booking");
                    } else {
                        response.sendRedirect("index.jsp?page=category");
                    }
                } else if (doSth.equals("del_booking")) {
                    Integer BookingId = Integer.parseInt(request.getParameter("booking_id"), 10);
                    BookingDatabase delBook = new BookingDatabase(ConnectionPro.getConnection());
                    if (delBook.deleteBooking(BookingId)) {
                        response.sendRedirect("index.jsp?page=booking");
                    } else {
                        response.sendRedirect("index.jsp?page=booking");
                    }
                } else if (doSth.equals("mark_booking")) {
                    Integer BookingId = Integer.parseInt(request.getParameter("booking_id"), 10);
                    BookingDatabase markBook = new BookingDatabase(ConnectionPro.getConnection());
                    if (markBook.markPaid(BookingId)) {
                        response.sendRedirect("index.jsp?page=booking");
                    } else {
                        response.sendRedirect("index.jsp?page=booking");
                    }
                } else {
                    response.sendRedirect("index.jsp?page=category");
                }
            } else {
                response.sendRedirect("index.jsp?page=category");
            }
        } else {
            response.sendRedirect("index.jsp?page=category");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | IllegalAccessException | InstantiationException ex) {
            Logger.getLogger(BookingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | IllegalAccessException | InstantiationException ex) {
            Logger.getLogger(BookingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
