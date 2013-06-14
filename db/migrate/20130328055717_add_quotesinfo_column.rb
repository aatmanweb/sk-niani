class AddQuotesinfoColumn < ActiveRecord::Migration
  def up
	add_column :quotes, :info, :text
  end

  def down
  end
end
