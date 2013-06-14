class Quoteimage < ActiveRecord::Base
   attr_accessible :image_url, :name, :quoteimageable_id, :quoteimageable_type
   belongs_to :quoteimageable, :polymorphic => true
	mount_uploader :image_url, QuoteimagesUploader
end
