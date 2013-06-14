class AddBackimgPages < ActiveRecord::Migration
  def up
	add_column :pages, :backimg_url, :string 
	add_column :pages, :backimg_color, :string
	add_column :pages, :headimg_url, :string
	add_column :pages, :popular_name, :string   
	add_column :pages, :intro, :string
  end

  def down

  end
end
