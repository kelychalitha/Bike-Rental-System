/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BikeRental;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BikeDatabase {
    Connection con ;

    public BikeDatabase(Connection con) {
        this.con = con;
    }
    
    public boolean saveBike(BikeDAO bike){
        boolean set = false;
        try{
           String query = "insert into bikes (category_id,bike_name,bike_description,bike_image,price,time_unit) values(?,?,?,?,?,?)";
           
           PreparedStatement pt = this.con.prepareStatement(query);
           pt.setInt(1, bike.getCategoryId());
           pt.setString(2, bike.getName());
           pt.setString(3, bike.getDescription());
           pt.setString(4, bike.getImage());
           pt.setDouble(5, bike.getPrice());
           pt.setString(6, bike.getUnit());
           
           pt.executeUpdate();
           set = true;
        }catch(SQLException e){
            Logger.getLogger(BikeDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return set;
    }
    
    public boolean updateBike(BikeDAO bike){
        boolean set = false;
        try{
            String query ="update bikes set category_id=?,bike_name=?,bike_description=?,bike_image=?,price=?,time_unit=? where bike_id=?";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1, bike.getCategoryId());
            pst.setString(2, bike.getName());
            pst.setString(3, bike.getDescription());
            pst.setString(4, bike.getImage());
            pst.setDouble(5, bike.getPrice());
            pst.setString(6, bike.getUnit());
            pst.setInt(7, bike.getId());
            
            pst.executeUpdate();
            set = true;
        }catch(SQLException e){
            Logger.getLogger(BikeDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return set;
    }
    
    public boolean deleteBike(int bike_id){
        boolean set = false;
        try{
           String query = "delete from bikes where bike_id=?";
           
           PreparedStatement pt = this.con.prepareStatement(query);
           pt.setInt(1, bike_id);
           
           pt.executeUpdate();
           set = true;
        }catch(SQLException e){
            Logger.getLogger(BikeDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return set;
    }
    
    public boolean deleteFeedback(int f_id){
        boolean set = false;
        try{
           String query = "delete from feedback where feedback_id=?";
           
           PreparedStatement pt = this.con.prepareStatement(query);
           pt.setInt(1, f_id);
           
           pt.executeUpdate();
           set = true;
        }catch(SQLException e){
            Logger.getLogger(BikeDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return set;
    }
    
    public boolean addFeedback(int c_id, int b_id, int u_id, String fTitle, String fText){
        boolean set = false;
        try{
           String query = "insert into feedback (category_id, bike_id, user_id, feedback_title, feedback_text) values (?,?,?,?,?)";
           
           PreparedStatement pt = this.con.prepareStatement(query);
           pt.setInt(1, c_id);
           pt.setInt(2, b_id);
           pt.setInt(3, u_id);
           pt.setString(4, fTitle);
           pt.setString(5, fText);
           
           pt.executeUpdate();
           set = true;
        }catch(SQLException e){
            Logger.getLogger(BikeDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return set;
    }

}