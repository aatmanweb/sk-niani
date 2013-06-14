class Feedback < ActiveRecord::Base
  attr_accessible :emailid, :feedback, :name, :visible
   scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
end
