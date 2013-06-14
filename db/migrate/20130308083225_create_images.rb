class CreateImages < ActiveRecord::Migration
  def up
 create_table :images do |t|
      t.string :name
      t.string :image_url
      t.timestamps
    end
  end

  def down
  end
end
