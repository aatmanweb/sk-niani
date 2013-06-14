class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :emailid
      t.text :feedback
      t.boolean :visible, :default => false

      t.timestamps
    end
  end
end
