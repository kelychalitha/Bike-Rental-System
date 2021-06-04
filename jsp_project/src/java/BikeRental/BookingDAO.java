/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BikeRental;

/**
 *
 * @author kcwee
 */
public class BookingDAO {

    private int BookingId;
    private String Fromdate;
    private String Todate;
    private int UserId;
    private int CategoryId;
    private int BikeId;
    private Double BookingSum;
    private Double PaidSum;
    private String PaidDate;
    private String Paid;

    public BookingDAO() {
    }

    public BookingDAO(int BookingId) {
        this.BookingId = BookingId;
    }

    public BookingDAO(int BookingId, String Fromdate, String Todate) {
        this.BookingId = BookingId;
        this.Fromdate = Fromdate;
        this.Todate = Todate;
    }

    public BookingDAO(int BookingId, String Fromdate, String Todate, int UserId, int CategoryId, int BikeId) {
        this.BookingId = BookingId;
        this.Fromdate = Fromdate;
        this.Todate = Todate;
        this.UserId = UserId;
        this.CategoryId = CategoryId;
        this.BikeId = BikeId;
    }

    public BookingDAO(int BookingId, String Fromdate, String Todate, int UserId, int CategoryId, int BikeId, Double BookingSum, Double PaidSum, String PaidDate, String Paid) {
        this.BookingId = BookingId;
        this.Fromdate = Fromdate;
        this.Todate = Todate;
        this.UserId = UserId;
        this.CategoryId = CategoryId;
        this.BikeId = BikeId;
        this.BookingSum = BookingSum;
        this.PaidSum = PaidSum;
        this.PaidDate = PaidDate;
        this.Paid = Paid;
    }
    
    public BookingDAO(int BookingId, String Fromdate, String Todate, int UserId, int CategoryId, int BikeId, Double BookingSum, Double PaidSum, String PaidDate) {
        this.BookingId = BookingId;
        this.Fromdate = Fromdate;
        this.Todate = Todate;
        this.UserId = UserId;
        this.CategoryId = CategoryId;
        this.BikeId = BikeId;
        this.BookingSum = BookingSum;
        this.PaidSum = PaidSum;
        this.PaidDate = PaidDate;
    }

    public BookingDAO(String Fromdate, String Todate, int UserId, int CategoryId, int BikeId, Double BookingSum, Double PaidSum, String PaidDate) {
        this.Fromdate = Fromdate;
        this.Todate = Todate;
        this.UserId = UserId;
        this.CategoryId = CategoryId;
        this.BikeId = BikeId;
        this.BookingSum = BookingSum;
        this.PaidSum = PaidSum;
        this.PaidDate = PaidDate;
    }

    public BookingDAO(String Fromdate, String Todate, int UserId, int CategoryId, int BikeId, Double BookingSum) {
        this.Fromdate = Fromdate;
        this.Todate = Todate;
        this.UserId = UserId;
        this.CategoryId = CategoryId;
        this.BikeId = BikeId;
        this.BookingSum = BookingSum;
    }
    
    public int getId() {
        return BookingId;
    }

    public void setId(int BookingId) {
        this.BookingId = BookingId;
    }

    public String getFromdate() {
        return Fromdate;
    }

    public void setFromdate(String Fromdate) {
        this.Fromdate = Fromdate;
    }

    public String getTodate() {
        return Todate;
    }

    public void setTodate(String Todate) {
        this.Todate = Todate;
    }
    
    public String getPaidDate() {
        return PaidDate;
    }

    public void setPaidDate(String PaidDate) {
        this.PaidDate = PaidDate;
    }
    
    public String getPaid() {
        return Paid;
    }

    public void setPaid(String Paid) {
        this.Paid = Paid;
    }

    public int getUserId() {
        return UserId;
    }

    public void setUserId(int UserId) {
        this.UserId = UserId;
    }

    public int getCategoryId() {
        return CategoryId;
    }

    public void setCategoryId(int CategoryId) {
        this.CategoryId = CategoryId;
    }

    public int getBikeId() {
        return this.BikeId;
    }

    public void setBikeId(int BikeId) {
        this.BikeId = BikeId;
    }

    public Double getBookingSum() {
        return this.BookingSum;
    }

    public void setBookingSum(Double BookingSum) {
        this.BookingSum = BookingSum;
    }
    
    public Double getPaidSum() {
        return this.PaidSum;
    }

    public void setPaidSum(Double PaidSum) {
        this.PaidSum = PaidSum;
    }

}
