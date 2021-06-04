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
import javax.servlet.http.HttpSession;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Kely
 */
public class RegisterServlet extends HttpServlet {

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
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String errorMessage = null;
            HttpSession regSession = request.getSession();

            String em_regex = "^((?!\\.)[\\w-_.]*[^.])(@\\w+)(\\.\\w+(\\.\\w+)?[^.\\W])$";
            String pw_regex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^.&+=])(?=\\S+$).{8,25}$";

            Pattern epattern = Pattern.compile(em_regex);
            Pattern ppattern = Pattern.compile(pw_regex);

            Matcher ematcher = epattern.matcher(email);
            if (ematcher.matches() == false) {
                errorMessage = "Not valid e-mail";
                regSession.setAttribute("RegError", errorMessage);
                response.sendRedirect("index.jsp?page=register");
            } else {

                String password = request.getParameter("password");
                Matcher pmatcher = ppattern.matcher(password);
                if (pmatcher.matches() == false) {
                    errorMessage = "Invalid password<br/>"
                            + "Password should consist of:<br />"
                            + "- 1 number<br />"
                            + "- 1 lowercase letter<br />"
                            + "- 1 uppercase letter<br />"
                            + "- 1 cpecial char:<br />"
                            + "@#$%^&+=<br />"
                            + "- No space allowed<br />"
                            + "- Between 8 - 25 characters long<br />";
                    regSession.setAttribute("RegError", errorMessage);
                    response.sendRedirect("index.jsp?page=register");
                } else {
                    //make user object
                    UserDAO userModel = new UserDAO(name, email, password);

                    //create a database model
                    UserDatabase regUser = new UserDatabase(ConnectionPro.getConnection());
                    if (regUser.saveUser(userModel)) {
                        regSession.setAttribute("RegError", null);
                        response.sendRedirect("index.jsp");
                    } else {
                        errorMessage = "User Available";
                        regSession.setAttribute("RegError", errorMessage);
                        response.sendRedirect("index.jsp?page=register");
                    }
                }
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
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
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