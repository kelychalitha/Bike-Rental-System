/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BikeRental;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CatDatabase {
    Connection con ;

    public CatDatabase(Connection con) {
        this.con = con;
    }
    
    public boolean saveCategory(CategoryDAO cat){
        boolean set = false;
        try{
           String query = "insert into category (b_class,name,descr,long_desc,image_url,faq) values (?,?,?,?,?,?)";
           
           PreparedStatement pt = this.con.prepareStatement(query);
           pt.setString(1, cat.getBclass());
           pt.setString(2, cat.getName());
           pt.setString(3, cat.getDescription());
           pt.setString(4, cat.getLongDescription());
           pt.setString(5, cat.getImage());
           pt.setString(6, cat.getFaq());
           
           pt.executeUpdate();
           set = true;
        }catch(SQLException e){
            Logger.getLogger(BikeDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return set;
    }
    
    public boolean updateCat(CategoryDAO cat){
        boolean set = false;
        try{
            String query ="update category SET b_class=?,name=?,descr=?,long_desc=?,image_url=?,faq=? WHERE category_id=?;";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, cat.getBclass());
            pst.setString(2, cat.getName());
            pst.setString(3, cat.getDescription());
            pst.setString(4, cat.getLongDescription());
            pst.setString(5, cat.getImage());
            pst.setString(6, cat.getFaq());
            pst.setInt(7, cat.getId());
            
            pst.executeUpdate();
            set = true;
        }catch(SQLException e){
            Logger.getLogger(BikeDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return set;
    }
    
    public boolean deleteCat(int category_id){
        boolean set = false;
        try{
           String query = "delete from category where category_id=?";
           
           PreparedStatement pt = this.con.prepareStatement(query);
           pt.setInt(1, category_id);
           
           pt.executeUpdate();
           set = true;
        }catch(SQLException e){
            Logger.getLogger(BikeDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return set;
    }

}