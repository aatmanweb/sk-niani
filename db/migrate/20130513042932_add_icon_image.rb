class AddIconImage < ActiveRecord::Migration
  def up
add_column :subjects, :icon_image, :string
  end

  def down
  end
end
