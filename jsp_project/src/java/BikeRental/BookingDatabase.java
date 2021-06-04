/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BikeRental;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Kely Weerasooriya
 */
public class BookingDatabase {
    Connection con ;

    public BookingDatabase(Connection con) {
        this.con = con;
    }
    
    public boolean saveBooking(BookingDAO booking){
        boolean set = false;
        try{
           String query = "insert into booking (from_date,to_date,user_id,category_id,bike_id,booking_sum) values(?,?,?,?,?,?)";
           
           PreparedStatement pt = this.con.prepareStatement(query);
           pt.setString(1, booking.getFromdate());
           pt.setString(2, booking.getTodate());
           pt.setInt(3, booking.getUserId());
           pt.setInt(4, booking.getCategoryId());
           pt.setInt(5, booking.getBikeId());
           pt.setDouble(6, booking.getBookingSum());
           
           pt.executeUpdate();
           set = true;
        }catch(SQLException e){
            Logger.getLogger(BookingDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return set;
    }
    
    public boolean updateBooking(BookingDAO booking){
        boolean set = false;
        try{
            String query ="update booking set from_date=?,to_date=?,user_id=?,category_id=?,bike_id=?,paid=?,paid_date=?,paid_sum=? where booking_id=?";

            PreparedStatement pst = this.con.prepareStatement(query);
            
            pst.setString(1, booking.getFromdate());
            pst.setString(2, booking.getTodate());
            pst.setInt(3, booking.getUserId());
            pst.setInt(4, booking.getCategoryId());
            pst.setInt(5, booking.getBikeId());
            pst.setString(6, booking.getPaid());
            pst.setString(7, booking.getPaidDate());
            pst.setDouble(8, booking.getPaidSum());
            pst.setInt(9, booking.getId());
            
            pst.executeUpdate();
            set = true;
        }catch(SQLException e){
            Logger.getLogger(BookingDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return set;
    }
    
    public boolean markPaid(int BookingId){
        boolean set = false;
        try{
            String query ="update booking set paid='Yes',paid_date=?,paid_sum=booking_sum where booking_id=?";
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDateTime  localDate = LocalDateTime .now();
            PreparedStatement pst = this.con.prepareStatement(query);
            
            pst.setString(1, dtf.format(localDate));
            pst.setInt(2, BookingId);
            
            pst.executeUpdate();
            set = true;
        }catch(SQLException e){
            Logger.getLogger(BookingDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return set;
    }
    
    public boolean deleteBooking(int BookingId){
        boolean set = false;
        try{
           String query = "delete from booking where booking_id=?";
           
           PreparedStatement pt = this.con.prepareStatement(query);
           pt.setInt(1, BookingId);
           
           pt.executeUpdate();
           set = true;
        }catch(SQLException e){
            Logger.getLogger(BookingDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return set;
    }

}

