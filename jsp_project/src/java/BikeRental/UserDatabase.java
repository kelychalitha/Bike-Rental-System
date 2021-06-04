/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BikeRental;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDatabase {
    Connection con ;

    public UserDatabase(Connection con) {
        this.con = con;
    }
    
    //for register user 
    public boolean saveUser(UserDAO user){
        boolean set = false;
        try{
           //Insert register data to database
           String query = "insert into user(name,email,password) values(?,?,MD5(?))";
           
           PreparedStatement pt = this.con.prepareStatement(query);
           pt.setString(1, user.getName());
           pt.setString(2, user.getEmail());
           pt.setString(3, user.getPassword());
           
           pt.executeUpdate();
           set = true;
        }catch(SQLException e){
            Logger.getLogger(BikeDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return set;
    }
    //user login
    public UserDAO login(String email, String pass){
        UserDAO usr=null;
        try{
            String query ="select * from user where email=? and password=MD5(?)";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, pass);
            
            ResultSet rs = pst.executeQuery();
            
            if(rs.next()){
                usr = new UserDAO();
                usr.setId(rs.getInt("id"));
                usr.setName(rs.getString("name"));
                usr.setEmail(rs.getString("email"));
                usr.setPassword(rs.getString("password"));
                usr.setAdmin(rs.getString("admin"));  
            }
            
        }catch(SQLException e){
            Logger.getLogger(BikeDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return usr;
    }

}