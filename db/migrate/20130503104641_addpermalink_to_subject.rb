class AddpermalinkToSubject < ActiveRecord::Migration
  def change
 add_column :subjects, :permalink, :string
  end
end
