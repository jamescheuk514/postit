class Vote < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  belongs_to :voteable, polymorphic: true

  validates_uniqueness_of :creator, scope: [:voteable_type, :voteable_id]
  validates_presence_of :creator, :voteable_type, :voteable_id 
end
