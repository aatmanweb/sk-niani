class AddpermalinkToSubSubject < ActiveRecord::Migration
   def change
 add_column :sub_subjects, :permalink, :string
  end
end
