class CreateAdvertisements < ActiveRecord::Migration
  def self.up
    create_table :advertisements do |t|
       t.string :adv_name                                 # alt = "a"
       t.string :adv_type                                 # image<img src="" /> or video <object src="" />
       t.string :adv_url                                  # a.jpg
       t.string :adv_position                             # left,right,..
       t.string :location_type                            #subject,..
       t.integer :location_id                             # Bio - ID
       t.datetime :expiry_date
 
       t.timestamps
    end
  end
  def self.down
    drop_table :advertisements
  end
end
