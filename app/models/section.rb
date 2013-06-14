require 'position_mover'
class Section < ActiveRecord::Base
  attr_accessible :name, :position, :visible, :contenttype, :content, :page_id
 include PositionMover
  belongs_to :page
  has_many :section_edits
  has_many :editors, :through => :section_edits, :class_name => "AdminUser"
  has_many :advertisements, :as => :location
  
  CONTENT_TYPES = ['text', 'HTML']
  
  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_inclusion_of :contenttype, :in => CONTENT_TYPES, 
    :message => "must be one of: #{CONTENT_TYPES.join(', ')}"
  validates_presence_of :content
  
  scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
  scope :sorted, order('sections.position ASC')
  
def self.search(search_string,search_string1,search_string2,search_string3,search_string4)
	  search_condition = "%" + search_string + "%"
	  search_condition1 = "%"+search_string1+"%"
	  search_condition2 = "%"+search_string2+"%"
          search_condition3 = "%"+search_string3+"%"
          search_condition4 = "%"+search_string4+"%"
  	  find(:all, :conditions => ['name LIKE ? OR content LIKE ? OR name LIKE ? OR content LIKE ? OR name LIKE ? OR content LIKE ? OR name LIKE ? OR content LIKE ? OR name LIKE ? OR content LIKE ? ', search_condition,search_condition,search_condition1, search_condition1,search_condition2,search_condition2,search_condition3,search_condition3,search_condition4,search_condition4],:group => 'page_id')
	end

  private
  
  def position_scope
    "sections.page_id = #{page_id.to_i}"
  end
  
end
