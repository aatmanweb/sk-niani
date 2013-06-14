class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string "name", :limit => 15
      t.integer "position"
      t.boolean "visible", :default => false
      t.timestamps
    end
  end
end
