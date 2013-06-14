require 'position_mover'
class Subject < ActiveRecord::Base
  attr_accessible :name, :position, :visible, :Subject_id, :image_url, :name, :imageable_id, :content, :imageable_type, :permalink,:icon_image
  include PositionMover
  mount_uploader :icon_image, ImagesUploader
  has_many :pages
  has_many :sub_subjects
  has_many :images, :as => :imageable
  has_many :search_eng_opt, :as => :meta
  has_many :advertisements, :as => :location

  # Don't need to validate (in most cases):
  #   ids, foreign keys, timestamps, booleans, counters
  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  # validates_presence_of vs. validates_length_of :minimum => 1
  # different error messages: "can't be blank" or "is too short"
  # validates_length_of allows strings with only spaces!
  
  scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
  scope :sorted, order('subjects.position ASC')

 def self.search(search_string,search_string1,search_string2,search_string3,search_string4)
	  search_condition = "%" + search_string + "%"
	  search_condition1 = "%"+search_string1+"%"
	  search_condition2 = "%"+search_string2+"%"
          search_condition3 = "%"+search_string3+"%"
          search_condition4 = "%"+search_string4+"%"
  	  find(:all, :conditions => ['name LIKE ? OR content LIKE ? OR name LIKE ? OR content LIKE ? OR name LIKE ? OR content LIKE ? OR name LIKE ? OR content LIKE ? OR name LIKE ? OR content LIKE ? ', search_condition,search_condition,search_condition1, search_condition1,search_condition2,search_condition2,search_condition3,search_condition3,search_condition4,search_condition4])

	end

end
