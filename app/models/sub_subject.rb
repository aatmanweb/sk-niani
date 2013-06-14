require 'position_mover'
class SubSubject < ActiveRecord::Base
  attr_accessible :name, :position, :visible, :subject_id, :content, :imageable_id, :permalink

   include PositionMover  

  belongs_to :subject
  has_many :images, :as => :imageable
  has_many :pages
  has_many :search_eng_opt, :as => :meta
  has_many :advertisements, :as => :location
  validates_presence_of :name
  validates_length_of :name, :maximum => 255  
  scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
  scope :sorted, order('sub_subjects.position ASC')
  
  private
  
  def position_scope
    "sub_subjects.subject_id = #{subject_id.to_i}"
  end

end
