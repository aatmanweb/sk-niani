
class Topic < ActiveRecord::Base
  attr_accessible :topic_name, :image_url, :name, :quoteimageable_id, :quoteimageable_type
   has_many :quoteimages, :as => :quoteimageable
   has_many :quotes
   validates :topic_name, :uniqueness => { :case_sensitive => false }

def self.topicsearch(search_string,search_string1,search_string2,search_string3,search_string4)
	  search_condition = "%" + search_string + "%"
	  search_condition1 = "%"+search_string1+"%"
	  search_condition2 = "%"+search_string2+"%"
          search_condition3 = "%"+search_string3+"%"
          search_condition4 = "%"+search_string4+"%"
  	  find(:all, :conditions => ['topic_name LIKE ? OR topic_name LIKE ? OR topic_name LIKE ? OR topic_name LIKE ? OR topic_name LIKE ?', search_condition, search_condition1,search_condition2,search_condition3,search_condition4], :limit => 5)
	end
end
