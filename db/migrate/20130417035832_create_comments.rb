class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
		t.integer :page_id
      t.string :name
      t.string :emailid
      t.string :website
      t.text :comment
      t.boolean "visible", :default => false
      t.timestamps
    end
    add_index("comments", "page_id")
  end
end
