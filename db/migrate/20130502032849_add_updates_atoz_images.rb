class AddUpdatesAtozImages < ActiveRecord::Migration
  def up
 add_column :pages, :updateimg_url, :string
 add_column :pages, :atozimg_url, :string
  end

  def down
  end
end
