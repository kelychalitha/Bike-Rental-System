/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BikeRental;


public class BikeDAO {
    private int bike_id;
    private int category_id;
    private String bike_name;
    private String bike_description;
    private String bike_image;
    private Double price;
    private String time_unit;
    private String added;

    public BikeDAO() {
    }
    
    public BikeDAO(int bike_id) {
        this.bike_id = bike_id;
    }
    
    public BikeDAO(int category_id, String bike_name, String bike_description, String bike_image, Double price, String time_unit) {
        this.category_id = category_id;
        this.bike_name = bike_name;
        this.bike_description = bike_description;
        this.bike_image = bike_image;
        this.price = price;
        this.time_unit = time_unit;
    }

    public BikeDAO(int bike_id, int category_id, String bike_name, String bike_description, String bike_image, Double price, String time_unit) {
        this.bike_id = bike_id;
        this.category_id = category_id;
        this.bike_name = bike_name;
        this.bike_description = bike_description;
        this.bike_image = bike_image;
        this.price = price;
        this.time_unit = time_unit;
    }
    
    public BikeDAO(int bike_id, int category_id, String bike_name, String bike_description, String bike_image, Double price, String time_unit, String added) {
        this.bike_id = bike_id;
        this.bike_name = bike_name;
        this.bike_description = bike_description;
        this.bike_image = bike_image;
        this.price = price;
        this.time_unit = time_unit;
        this.added = added;
    }

    public int getId() {
        return bike_id;
    }

    public void setId(int bike_id) {
        this.bike_id = bike_id;
    }
    
    public int getCategoryId() {
        return category_id;
    }

    public void setCategoryId(int category_id) {
        this.category_id = category_id;
    }

    public String getName() {
        return bike_name;
    }
    

    public void setName(String bike_name) {
        this.bike_name = bike_name;
    }
    
    public String getDescription() {
        return bike_description;
    }

    public void setDescription(String bike_description) {
        this.bike_description = bike_description;
    }
    
    public String getImage() {
        return bike_image;
    }
    
    public void setImage(String bike_image) {
        this.bike_image = bike_image;
    }
    
    public Double getPrice() {
        return this.price;
    }
    
    public void setPrice(Double price) {
        this.price = price;
    }
    
    public String getUnit() {
        return time_unit;
    }
    
    public void setUnit(String time_unit) {
        this.time_unit = time_unit;
    }
    
    public String getAdded() {
        return added;
    }
    
    public void setAdded(String added) {
        this.added = added;
    }
    
    
}



