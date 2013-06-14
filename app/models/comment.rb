class Comment < ActiveRecord::Base
    attr_accessible :comment, :emailid, :name, :website, :page_id, :visible
  belongs_to :page
  scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
end
