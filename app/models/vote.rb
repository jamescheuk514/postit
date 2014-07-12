class Vote < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  belongs_to :voteable, polymorphic: true

  validates_uniqueness_of :creator, scope: :voteable
  validates :creator, presence: true
  validates :voteable_type, presence: true
  validates :voteable_id, presence: true
end
