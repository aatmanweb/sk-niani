class CreateQuoteimages < ActiveRecord::Migration
  def change
    create_table :quoteimages do |t|
      t.string :name
      t.string :image_url
      t.integer :quoteimageable_id
      t.string :quoteimageable_type
      t.timestamps
    end
  end
end
