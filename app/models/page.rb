require 'position_mover'
class Page < ActiveRecord::Base
   attr_accessible :name, :permalink, :position, :visible, :subject_id, :sub_subject_id, :image_url, :name, :imageable_id, :imageable_type, :backimg_url, :backimg_color, :headimg_url, :popular_name, :intro, :updateimg_url, :atozimg_url
mount_uploader :backimg_url, ImagesUploader	
mount_uploader :headimg_url, ImagesUploader
mount_uploader :updateimg_url, ImagesUploader
mount_uploader :atozimg_url, ImagesUploader
include PositionMover
  
  belongs_to :subject
  belongs_to :sub_subject
  has_many :sections
  has_many :comments
  has_many :images, :as => :imageable
  has_many :search_eng_opt, :as => :meta
  has_and_belongs_to_many :editors, :class_name => "AdminUser"
  has_many :advertisements, :as => :location

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_presence_of :permalink
  validates_length_of :permalink, :within => 3..255
  # use presence with length to disallow spaces
  validates_uniqueness_of :permalink
    # for unique values by subject, :scope => :subject_id
  
  scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
  scope :sorted, order('pages.position ASC')
  

 def self.search(search_string)
	  search_condition = "%"+search_string+"%"
  	  find(:all, :conditions => ['name LIKE ? OR popular_name LIKE ?', search_condition, search_condition],:group => 'id')
	end
 def self.subjectpagesearch(search_string,search_string1,search_string2,search_string3,search_string4)
	  search_condition = "%" + search_string + "%"
	  search_condition1 = "%"+search_string1+"%"
	  search_condition2 = "%"+search_string2+"%"
          search_condition3 = "%"+search_string3+"%"
          search_condition4 = "%"+search_string4+"%"
  	  find(:all, :conditions => ['name LIKE ? OR popular_name LIKE ? OR name LIKE ? OR popular_name LIKE ? OR name LIKE ? OR popular_name LIKE ? OR name LIKE ? OR popular_name LIKE ? OR name LIKE ? OR popular_name LIKE ? ', search_condition,search_condition,search_condition1, search_condition1,search_condition2,search_condition2,search_condition3,search_condition3,search_condition4,search_condition4], :limit => 5)
 
	end
  private
  
  def position_scope
    "pages.subject_id = #{subject_id.to_i}"
  end

end
