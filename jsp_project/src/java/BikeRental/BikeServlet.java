/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BikeRental;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author Kely
 */
public class BikeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     * @throws java.lang.InstantiationException
     * @throws java.lang.IllegalAccessException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String doSth = request.getParameter("doSth");
            String bike_id = request.getParameter("bike_id");
            String category_id = request.getParameter("category_id");
            String bike_name = request.getParameter("bike_name");
            String bike_description = request.getParameter("bike_description");
            String bike_image = request.getParameter("bike_image");
            String price = request.getParameter("price");
            String time_unit = request.getParameter("time_unit");
            String name = request.getParameter("name");
            String b_class = request.getParameter("b_class");
            String desc = request.getParameter("desc");
            String long_desc = request.getParameter("long_desc");
            String image_url = request.getParameter("image_url");
            String faq = request.getParameter("faq");

            int bike_id2 = 0;
            int category_id2 = 0;
            Double price2 = 0.00;
            if (bike_id != null && bike_id.length() > 0) {
                bike_id2 = Integer.parseInt(bike_id, 10);
            }
            if (category_id != null && category_id.length() > 0) {
                category_id2 = Integer.parseInt(category_id, 10);
            }
            if (price != null && price.length() > 0.01) {
                price2 = Double.parseDouble(price);
            }

            if (doSth != null && doSth.isEmpty() == false) {
                String[] safe_actions = new String[]{"add_bike", "del_bike", "upd_bike", "add_cat", "del_cat", "upd_cat", "del_feedback", "add_feedback"};
                // Convert String Array to List
                List<String> list = Arrays.asList(safe_actions);
                if (list.contains(doSth)) {
                    if (doSth.equals("add_bike")) {
                        BikeDAO bikeModel = new BikeDAO(category_id2, bike_name, bike_description, bike_image, price2, time_unit);
                        //create a database model
                        BikeDatabase saveBike = new BikeDatabase(ConnectionPro.getConnection());
                        if (saveBike.saveBike(bikeModel)) {
                            response.sendRedirect("index.jsp?page=category&cat=" + category_id2);
                        } else {
                            response.sendRedirect("index.jsp?page=category");
                        }
                    }
                    if (doSth.equals("del_bike")) {
                        BikeDatabase delBike = new BikeDatabase(ConnectionPro.getConnection());
                        if (delBike.deleteBike(bike_id2)) {
                            response.sendRedirect("index.jsp?page=category&cat=" + category_id2);
                        } else {
                            response.sendRedirect("index.jsp?page=category");
                        }
                    }
                    if (doSth.equals("del_feedback")) {
                        BikeDatabase delFeedback = new BikeDatabase(ConnectionPro.getConnection());
                        Integer f_id = Integer.parseInt(request.getParameter("f_id"), 10);
                        if (delFeedback.deleteFeedback(f_id)) {
                            response.sendRedirect("index.jsp?page=feedback");
                        } else {
                            response.sendRedirect("index.jsp?page=feedback");
                        }
                    }
                    if (doSth.equals("add_feedback")) {
                        BikeDatabase addFeedback = new BikeDatabase(ConnectionPro.getConnection());
                        Integer c_id = Integer.parseInt(request.getParameter("c_id"), 10);
                        Integer b_id = Integer.parseInt(request.getParameter("b_id"), 10);
                        Integer u_id = Integer.parseInt(request.getParameter("u_id"), 10);
                        String fTitle = request.getParameter("fTitle");
                        String fText = request.getParameter("fText");
                        if (addFeedback.addFeedback(c_id,b_id,u_id,fTitle,fText)) {
                            response.sendRedirect("index.jsp?page=feedback");
                        } else {
                            response.sendRedirect("index.jsp?page=category");
                        }
                    }
                    if (doSth.equals("upd_bike")) {
                        BikeDAO bikeModel2 = new BikeDAO(bike_id2, category_id2, bike_name, bike_description, bike_image, price2, time_unit);
                        BikeDatabase updateBike = new BikeDatabase(ConnectionPro.getConnection());
                        if (updateBike.updateBike(bikeModel2)) {
                            response.sendRedirect("index.jsp?page=category&cat=" + category_id2);
                        } else {
                            response.sendRedirect("index.jsp?page=category");
                        }
                    }
                    if (doSth.equals("add_cat")) {
                        CategoryDAO bcatModel = new CategoryDAO(b_class, name, desc, long_desc, image_url, faq);
                        //create a database model
                        CatDatabase saveCat = new CatDatabase(ConnectionPro.getConnection());
                        if (saveCat.saveCategory(bcatModel)) {
                            response.sendRedirect("index.jsp?page=category");
                        } else {
                            response.sendRedirect("index.jsp?page=category");
                        }
                    }
                    if (doSth.equals("del_cat")) {
                        CatDatabase delCat = new CatDatabase(ConnectionPro.getConnection());
                        if (delCat.deleteCat(category_id2)) {
                            response.sendRedirect("index.jsp?page=category");
                        } else {
                            response.sendRedirect("index.jsp?page=category");
                        }
                    }
                    if (doSth.equals("upd_cat")) {
                        CategoryDAO catModel2 = new CategoryDAO(b_class, name, desc, long_desc, image_url, faq, category_id2);
                        CatDatabase updateCat = new CatDatabase(ConnectionPro.getConnection());
                        if(updateCat.updateCat(catModel2)) {
                            response.sendRedirect("index.jsp?page=category&cat=" + category_id2);
                        } else {
                            response.sendRedirect("index.jsp?page=category");
                        }
                    }
                } else {
                    response.sendRedirect("index.jsp?page=category");
                }

            } else {
                response.sendRedirect("index.jsp?page=category");
            }
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
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException ex) {
            Logger.getLogger(BikeServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException ex) {
            Logger.getLogger(BikeServlet.class.getName()).log(Level.SEVERE, null, ex);
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