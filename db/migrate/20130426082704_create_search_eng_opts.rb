class CreateSearchEngOpts < ActiveRecord::Migration
  def self.up
    create_table :search_eng_opts do |t|
      t.integer :meta_id
      t.string :meta_type
      t.string :keyword

      t.timestamps
    end
  end
  def self.down
   drop_table :search_eng_opts
  end

end
