class Advertisement < ActiveRecord::Base
   attr_accessible :id, :adv_name, :adv_type, :adv_url, :flashimage, :adv_position, :location_type, :location_parent_id, :location_id, :location_name, :expiry_date
   has_and_belongs_to_many :subjects
   belongs_to :location, :polymorphic => true
   mount_uploader :adv_url, AdvertisementUploader
   mount_uploader :flashimage, AdvertiseFlashImageUploader
end
