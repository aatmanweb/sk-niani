class AddFlashimageToAdvertisements < ActiveRecord::Migration
  def self.up
    add_column :advertisements, :flashimage, :string, :after => 'adv_url'
  end
  def self.down
    remove_column :advetisements, :flashimage
  end
end
