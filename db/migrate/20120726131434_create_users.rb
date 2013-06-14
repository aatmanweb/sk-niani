class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
	
	t.string "first_name", :limit => 2
        t.string "last_name", :limit => 50
        t.string "email", :default => "", :null => false
        t.string "password", :limit => 40
        t.timestamps
    end
  end
end
