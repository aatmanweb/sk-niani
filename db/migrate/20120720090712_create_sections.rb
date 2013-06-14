class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :page_id
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default => false
      t.string "contenttype"
      t.text "content"
      t.timestamps
    end
      add_index("sections", "page_id")
  end
end
