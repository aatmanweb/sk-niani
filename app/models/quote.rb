class Quote < ActiveRecord::Base
Quote.cache do
   attr_accessible :language, :title, :quote, :image_url, :name, :quoteimageable_id, :quoteimageable_type,
   :topic_id, :author_id, :topic_name, :author_name, :publish_at, :publish_at_date, :publish_at_time, :topic_names, :info
   has_many :quoteimages, :as => :quoteimageable
   belongs_to :topic
   belongs_to :author
   attr_accessor :topic_names
 
   validates :title, :quote, :presence => true


  # add the accessors for the two fields
  attr_accessor :publish_at_date, :publish_at_time
  

 # add some callbacks
  after_initialize :get_datetimes # convert db format to accessors
  before_validation :set_datetimes # convert accessors back to db format

  def get_datetimes
    self.publish_at ||= Time.now  # if the published_at time is not set, set it to now

    self.publish_at_date ||= self.publish_at.to_date.to_s(:db) # extract the date is yyyy-mm-dd format
    self.publish_at_time ||= "#{'%02d' % self.publish_at.hour}:#{'%02d' % self.publish_at.min}" # extract the time
  end

  def set_datetimes
    self.publish_at = "#{self.publish_at_date} #{self.publish_at_time}:00" # convert the two fields back to db
  end  

def self.search(search_string,search_string1,search_string2,search_string3)
	 search_condition = "%" + search_string + "%"
	  search_condition1 = "%"+search_string1+"%"
	  search_condition2 = "%"+search_string2+"%"
          search_condition3 = "%"+search_string3+"%"
  	  find(:all, :conditions => ['title LIKE ? OR quote LIKE ? OR title LIKE ? OR quote LIKE ?  OR title LIKE ? OR quote LIKE ?  OR title LIKE ? OR quote LIKE ?', search_condition, search_condition, search_condition1, search_condition1, search_condition2, search_condition2, search_condition3, search_condition3],:group => 'author_id',:limit => 2)
	end 
end
end
