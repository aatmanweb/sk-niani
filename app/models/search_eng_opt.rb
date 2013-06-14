class SearchEngOpt < ActiveRecord::Base
  attr_accessible :keyword, :meta_id, :meta_type
  belongs_to :meta, :polymorphic => true
end
