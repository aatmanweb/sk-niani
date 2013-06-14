class AddColumnToSubjects < ActiveRecord::Migration
  def change
 
  add_column :subjects, :content, :text
  end
end
