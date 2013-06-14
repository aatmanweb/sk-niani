class Image < ActiveRecord::Base
   attr_accessible :image_url, :name, :imageable_id, :imageable_type
belongs_to :imageable, :polymorphic => true
mount_uploader :image_url, ImagesUploader
end
