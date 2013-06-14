class CreateSubSubjects < ActiveRecord::Migration
  def change
    create_table :sub_subjects do |t|
      t.integer :subject_id
      t.text :name, :limit => 15
      t.integer :position
      t.boolean :visible, :default => false
      t.timestamps
   
    end
      add_index("sub_subjects", "subject_id")
  end
end
