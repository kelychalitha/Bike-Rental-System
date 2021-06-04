/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BikeRental;


public class CategoryDAO {
    private int category_id;
    private String b_class;
    private String name;
    private String desc;
    private String long_desc;
    private String image_url;
    private String faq;

    public CategoryDAO() {
    }
    
    public CategoryDAO(String b_class, String name, String desc, String long_desc, String image_url) {
        this.b_class = b_class;
        this.name = name;
        this.desc = desc;
        this.long_desc = long_desc;
        this.image_url = image_url;
    }
    
    public CategoryDAO(String b_class, String name, String desc, String long_desc, String image_url, String faq) {
        this.b_class = b_class;
        this.name = name;
        this.desc = desc;
        this.long_desc = long_desc;
        this.image_url = image_url;
        this.faq = faq;
    }

    public CategoryDAO(String b_class, String name, String desc, String long_desc, String image_url, String faq, Integer category_id) {
        this.category_id = category_id;
        this.b_class = b_class;
        this.name = name;
        this.desc = desc;
        this.long_desc = long_desc;
        this.image_url = image_url;
        this.faq = faq;
    }

    CategoryDAO(String BookingId, String Fromdate, String Todate, String CategoryId, String UserId, String BikeId, String BookingSum) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    

    public int getId() {
        return category_id;
    }

    public void setId(int bike_id) {
        this.category_id = bike_id;
    }
    

    public String getName() {
        return name;
    }
    

    public void setName(String name) {
        this.name = name;
    }
    
    public String getDescription() {
        return desc;
    }

    public void setDescription(String desc) {
        this.desc = desc;
    }
    
    public String getLongDescription() {
        return long_desc;
    }

    public void setLongDescription(String long_desc) {
        this.desc = long_desc;
    }
    
    public String getImage() {
        return image_url;
    }
    
    public void setImage(String image_url) {
        this.image_url = image_url;
    }
    
    public String getFaq() {
        return this.faq;
    }
    
    public void setFaq(String faq) {
        this.faq = faq;
    }
    
    public String getBclass() {
        return b_class;
    }
    
    public void setBclass(String b_class) {
        this.b_class = b_class;
    }
    
    
}



