class CreateSiteusers < ActiveRecord::Migration
  def change
    create_table :siteusers do |t|
		t.string "username", :limit =>25
      t.string "email", :default => "", :null => false, :limit =>100
      t.string "hashed_password", :limit => 40
		t.string "salt", :limit => 40
		t.string "status", :limit =>25
      t.timestamps
    end
  end
  add_index("siteusers", "username")	
end
