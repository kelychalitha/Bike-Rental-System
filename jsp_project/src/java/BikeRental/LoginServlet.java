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
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 *
 * @author Kely
 */
public class LoginServlet extends HttpServlet {

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
            //feth data from login form
            String errorMessage = null;
            String logemail = request.getParameter("email");
            String logpass = request.getParameter("password");
            
            UserDatabase db =  new UserDatabase(ConnectionPro.getConnection());
            UserDAO user = db.login(logemail, logpass);
            
            if(user!=null){
                HttpSession session = request.getSession();
                session.setAttribute("logUser", user.getName());
                session.setAttribute("logUserMail", user.getEmail());
                session.setAttribute("logAdmin", user.getAdmin());
                //add user id to session also :)
                session.setAttribute("logId", user.getId());
                
                Cookie username = new Cookie("logUser",
                        user.getName());
                Cookie email = new Cookie("logUserMail",
                        user.getEmail());
                Cookie isadmin = new Cookie("logAdmin",
                        user.getAdmin());

                username.setMaxAge(60 * 60 * 10);
                username.setHttpOnly(true);
                username.setSecure(request.isSecure());
                username.setPath(request.getContextPath() + "/");
                email.setMaxAge(60 * 60 * 10);
                email.setHttpOnly(true);
                email.setSecure(request.isSecure());
                email.setPath(request.getContextPath() + "/");
                isadmin.setMaxAge(60 * 60 * 10);
                isadmin.setHttpOnly(true);
                isadmin.setSecure(request.isSecure());
                isadmin.setPath(request.getContextPath() + "/");

                // Add both the cookies in the response header.
                response.addCookie(username);
                response.addCookie(email);
                response.sendRedirect("index.jsp");
            }else{
                errorMessage = "Wrong username/password";
                HttpSession regSession = request.getSession();
                regSession.setAttribute("RegError", errorMessage);
                response.sendRedirect("index.jsp?page=login");
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
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
