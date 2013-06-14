class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer "topic_id"
      t.integer "author_id"
      t.string :language
      t.text :title
      t.text :quote
      t.datetime :publish_at
      t.timestamps
    end
  end
end
