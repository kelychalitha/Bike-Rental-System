/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package BikeRental;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ConnectionPro {
    private static Connection con;
    
    public static Connection getConnection() throws ClassNotFoundException, InstantiationException, IllegalAccessException{
        try{
            
            Object Object; /*newInstance*/
            Object = Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp_project?serverTimezone=UTC","root","");
            
        }catch(SQLException e){
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, e);
        }
        return con;
    }
}


